$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Drawing
$root=Join-Path $PSScriptRoot '../remaster/assets/pigeon-fat'
New-Item -ItemType Directory -Force (Join-Path $root 'frames') | Out-Null
function Bounds($b,$sx,$sy,$size){
 $left=$size;$top=$size;$right=-1;$bottom=-1
 for($y=0;$y -lt $size;$y++){for($x=0;$x -lt $size;$x++){if($b.GetPixel($sx+$x,$sy+$y).A -gt 32){$left=[Math]::Min($left,$x);$top=[Math]::Min($top,$y);$right=[Math]::Max($right,$x);$bottom=[Math]::Max($bottom,$y)}}}
 return @{x=$left;y=$top;width=$right-$left+1;height=$bottom-$top+1;bottom=$bottom}
}
$sets=@(
 @{name='idle';frames=2;loop=$true;map=@(0,0)},
 @{name='fly';frames=8;loop=$true;map=@(0,1,2,3,4,5,2,1)},
 @{name='hop';frames=9;loop=$false;map=@(0,1,2,3,3,4,4,5,5)},
 @{name='landing';frames=21;loop=$true;map=@(0,0,1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,5,5,5,5)},
 @{name='attack';frames=12;loop=$false;map=@(0,1,1,2,2,3,3,4,4,5,5,0)},
 @{name='hit';frames=14;loop=$false;map=@(0,1,1,2,2,2,3,3,3,4,4,4,5,5)},
 @{name='death';frames=10;loop=$true;map=@(0,1,1,2,2,3,3,4,4,5)}
)
$atlas=[Drawing.Bitmap]::new(1620,1680,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
$ga=[Drawing.Graphics]::FromImage($atlas);$ga.Clear([Drawing.Color]::Transparent)
$records=@();$row=0
foreach($set in $sets){
 $version='v1'
 $idle=$set.name -eq 'idle'
 $file=if($idle){'fat-pigeon-idle-master-v1.png'}else{'fat-pigeon-'+$set.name+'-keyposes-v1.png'}
 $sheet=[Drawing.Bitmap]::new((Join-Path $root $file))
 $size=if($idle){$sheet.Width}else{512}
 if(!$idle -and ($sheet.Width -ne 1536 -or $sheet.Height -ne 1024)){throw 'Unexpected sheet size'}
 for($y=0;$y -lt $sheet.Height;$y++){for($x=0;$x -lt $sheet.Width;$x++){if($sheet.GetPixel($x,$y).A -le 24){$sheet.SetPixel($x,$y,[Drawing.Color]::Transparent)}}}
 $refPose=if($set.name -eq 'landing'){5}else{0}
 $bounds=Bounds $sheet (($refPose%3)*$size) ([int][Math]::Floor($refPose/3)*$size) $size
 $scale=179.0/$bounds.height
 for($pose=0;$pose -lt 6;$pose++){
  $sx=if($idle){0}else{($pose%3)*512};$sy=if($idle){0}else{[int][Math]::Floor($pose/3)*512}
  $f=[Drawing.Bitmap]::new(270,240,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
  $g=[Drawing.Graphics]::FromImage($f);$g.Clear([Drawing.Color]::Transparent)
  $g.InterpolationMode=[Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.PixelOffsetMode=[Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $dy=210-$bounds.bottom*$scale
  if($set.name -eq 'death'){$dy=120-($bounds.y+$bounds.height/2)*$scale}
  $rect=[Drawing.RectangleF]::new([single](135-($size/2)*$scale),[single]$dy,[single]($size*$scale),[single]($size*$scale))
  $g.DrawImage($sheet,$rect,[Drawing.RectangleF]::new($sx,$sy,$size,$size),[Drawing.GraphicsUnit]::Pixel);$g.Dispose()
  $f.Save((Join-Path $root ('frames/'+$set.name+'-key-{0:D2}.png' -f $pose)),[Drawing.Imaging.ImageFormat]::Png)
  $ga.DrawImageUnscaled($f,$pose*270,$row*240);$f.Dispose()
 }
 $records+=@{state=$set.name;row=$row;scale=$scale;sourceReferenceBounds=$bounds}
 $sheet.Dispose();$row++
}
$atlas.Save((Join-Path $root 'pigeon-atlas.png'),[Drawing.Imaging.ImageFormat]::Png);$ga.Dispose();$atlas.Dispose()
@{cell=@(270,240);columns=6;rows=7;renderScale=1.0/3;visibleIdleHeight=179.0/3;anchor=@(135,210);states=$sets;registration=$records}|ConvertTo-Json -Depth 8|Set-Content (Join-Path $root 'animation-manifest.json')
Write-Output 'Prepared 42 pigeon keys on the original 90x80 logical capture canvas at 3x resolution.'
$combined=[Drawing.Bitmap]::new(1620,3360,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
$gc=[Drawing.Graphics]::FromImage($combined);$gc.Clear([Drawing.Color]::Transparent)
$standard=[Drawing.Bitmap]::new((Join-Path $root '../pigeon/pigeon-atlas.png'))
$fat=[Drawing.Bitmap]::new((Join-Path $root 'pigeon-atlas.png'))
for($row=0;$row -lt 7;$row++){for($col=0;$col -lt 6;$col++){
 $gc.DrawImage($standard,[Drawing.Rectangle]::new($col*270+30,$row*240+33,210,174),[Drawing.Rectangle]::new($col*210,$row*174,210,174),[Drawing.GraphicsUnit]::Pixel)
}}
$gc.DrawImageUnscaled($fat,0,1680)
$combined.Save((Join-Path $root 'combined-pigeon-atlas.png'),[Drawing.Imaging.ImageFormat]::Png)
$standard.Dispose();$fat.Dispose();$gc.Dispose();$combined.Dispose()
Write-Output 'Combined standard and fat pigeon atlas prepared.'
