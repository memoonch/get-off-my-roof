$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Drawing
$root=Join-Path $PSScriptRoot '../remaster/assets/pigeon'
New-Item -ItemType Directory -Force (Join-Path $root 'frames') | Out-Null
function Bounds($b,$sx,$sy,$size){
 $left=$size;$top=$size;$right=-1;$bottom=-1
 for($y=0;$y -lt $size;$y++){for($x=0;$x -lt $size;$x++){if($b.GetPixel($sx+$x,$sy+$y).A -gt 32){$left=[Math]::Min($left,$x);$top=[Math]::Min($top,$y);$right=[Math]::Max($right,$x);$bottom=[Math]::Max($bottom,$y)}}}
 return @{x=$left;y=$top;width=$right-$left+1;height=$bottom-$top+1;bottom=$bottom}
}
$sets=@(
 @{name='idle';frames=33;loop=$true;map=@(0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,3,4,5,5,0,0,0)},
 @{name='fly';frames=8;loop=$true;map=@(0,1,2,3,4,5,2,1)},
 @{name='hop';frames=9;loop=$false;map=@(0,1,2,3,3,4,4,5,5)},
 @{name='landing';frames=21;loop=$true;map=@(0,0,1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,5,5,5,5)},
 @{name='attack';frames=12;loop=$false;map=@(0,1,1,2,2,3,3,4,4,5,5,0)},
 @{name='hit';frames=13;loop=$false;map=@(0,1,1,2,2,2,3,3,3,4,4,5,5)},
 @{name='death';frames=10;loop=$true;map=@(0,1,1,2,2,3,3,4,4,5)}
)
$atlas=[Drawing.Bitmap]::new(1260,1218,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
$ga=[Drawing.Graphics]::FromImage($atlas);$ga.Clear([Drawing.Color]::Transparent)
$records=@();$row=0
foreach($set in $sets){
 $version=if($set.name -eq 'death'){'v2'}else{'v1'}
 $sheet=[Drawing.Bitmap]::new((Join-Path $root ('pigeon-'+$set.name+'-keyposes-'+$version+'.png')))
 if($sheet.Width -ne 1536 -or $sheet.Height -ne 1024){throw 'Unexpected sheet size'}
 for($y=0;$y -lt 1024;$y++){for($x=0;$x -lt 1536;$x++){if($sheet.GetPixel($x,$y).A -le 24){$sheet.SetPixel($x,$y,[Drawing.Color]::Transparent)}}}
 $refPose=if($set.name -eq 'landing'){5}else{0}
 $bounds=Bounds $sheet (($refPose%3)*512) ([int][Math]::Floor($refPose/3)*512) 512
 $scale=159.0/$bounds.height
 for($pose=0;$pose -lt 6;$pose++){
  $sx=($pose%3)*512;$sy=[int][Math]::Floor($pose/3)*512
  $f=[Drawing.Bitmap]::new(210,174,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
  $g=[Drawing.Graphics]::FromImage($f);$g.Clear([Drawing.Color]::Transparent)
  $g.InterpolationMode=[Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.PixelOffsetMode=[Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $dy=168-$bounds.bottom*$scale
  if($set.name -eq 'death'){$dy=87-($bounds.y+$bounds.height/2)*$scale}
  $rect=[Drawing.RectangleF]::new([single](105-256*$scale),[single]$dy,[single](512*$scale),[single](512*$scale))
  $g.DrawImage($sheet,$rect,[Drawing.RectangleF]::new($sx,$sy,512,512),[Drawing.GraphicsUnit]::Pixel);$g.Dispose()
  $f.Save((Join-Path $root ('frames/'+$set.name+'-key-{0:D2}.png' -f $pose)),[Drawing.Imaging.ImageFormat]::Png)
  $ga.DrawImageUnscaled($f,$pose*210,$row*174);$f.Dispose()
 }
 $records+=@{state=$set.name;row=$row;scale=$scale;sourceReferenceBounds=$bounds}
 $sheet.Dispose();$row++
}
$atlas.Save((Join-Path $root 'pigeon-atlas.png'),[Drawing.Imaging.ImageFormat]::Png);$ga.Dispose();$atlas.Dispose()
@{cell=@(210,174);columns=6;rows=7;renderScale=1.0/3;visibleIdleHeight=53;anchor=@(105,168);states=$sets;registration=$records}|ConvertTo-Json -Depth 8|Set-Content (Join-Path $root 'animation-manifest.json')
Write-Output 'Prepared 42 pigeon keys on the original 70x58 logical capture canvas at 3x resolution.'
