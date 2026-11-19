$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Drawing
$root=Join-Path $PSScriptRoot '../remaster/assets/boss-bomber'
New-Item -ItemType Directory -Force (Join-Path $root 'frames') | Out-Null
function Bounds($b,$sx,$sy,$size){
 $left=$size;$top=$size;$right=-1;$bottom=-1
 for($y=0;$y -lt $size;$y++){for($x=0;$x -lt $size;$x++){if($b.GetPixel($sx+$x,$sy+$y).A -gt 32){$left=[Math]::Min($left,$x);$top=[Math]::Min($top,$y);$right=[Math]::Max($right,$x);$bottom=[Math]::Max($bottom,$y)}}}
 return @{x=$left;y=$top;width=$right-$left+1;height=$bottom-$top+1;bottom=$bottom}
}
$sets=@(
 @{name='idle';frames=2;loop=$true;map=@(0,0)},
 @{name='fly';frames=9;loop=$true;map=@(0,1,1,2,3,4,5,2,1)},
 @{name='hop';frames=9;loop=$false;map=@(0,1,2,3,3,4,4,5,5)},
 @{name='landing';frames=21;loop=$true;map=@(0,0,1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,5,5,5,5)},
 @{name='attack';frames=12;loop=$false;map=@(0,1,1,2,2,3,3,4,4,5,5,0)},
 @{name='hit';frames=13;loop=$false;map=@(0,1,1,2,2,2,3,3,3,4,4,5,5)},
 @{name='death';frames=17;loop=$true;map=@(0,0,1,1,1,2,2,2,3,3,3,4,4,4,5,5,5)}
)
$atlas=[Drawing.Bitmap]::new(1980,2100,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
$ga=[Drawing.Graphics]::FromImage($atlas);$ga.Clear([Drawing.Color]::Transparent)
$records=@();$row=0
foreach($set in $sets){
 $version='v1'
 $idle=$set.name -eq 'idle'
 $file=if($idle){'boss-bomber-idle-master-v1.png'}else{'boss-bomber-'+$set.name+'-keyposes-v1.png'}
 if($set.name -eq 'death'){$file='boss-bomber-death-keyposes-v2.png'}
 $sheet=[Drawing.Bitmap]::new((Join-Path $root $file))
 $size=if($idle){$sheet.Width}else{512}
 if(!$idle -and ($sheet.Width -ne 1536 -or $sheet.Height -ne 1024)){throw 'Unexpected sheet size'}
 for($y=0;$y -lt $sheet.Height;$y++){for($x=0;$x -lt $sheet.Width;$x++){if($sheet.GetPixel($x,$y).A -le 24){$sheet.SetPixel($x,$y,[Drawing.Color]::Transparent)}}}
 $refPose=if($set.name -eq 'landing'){5}else{0}
 $bounds=Bounds $sheet (($refPose%3)*$size) ([int][Math]::Floor($refPose/3)*$size) $size
 $scale=270.5/$bounds.height
 for($pose=0;$pose -lt 6;$pose++){
  $sx=if($idle){0}else{($pose%3)*512};$sy=if($idle){0}else{[int][Math]::Floor($pose/3)*512}
  $f=[Drawing.Bitmap]::new(330,300,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
  $g=[Drawing.Graphics]::FromImage($f);$g.Clear([Drawing.Color]::Transparent)
  $g.InterpolationMode=[Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.PixelOffsetMode=[Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $dy=285-$bounds.bottom*$scale
  if($set.name -eq 'death'){$dy=150-($bounds.y+$bounds.height/2)*$scale}
  $rect=[Drawing.RectangleF]::new([single](165-($size/2)*$scale),[single]$dy,[single]($size*$scale),[single]($size*$scale))
  $g.DrawImage($sheet,$rect,[Drawing.RectangleF]::new($sx,$sy,$size,$size),[Drawing.GraphicsUnit]::Pixel);$g.Dispose()
  $f.Save((Join-Path $root ('frames/'+$set.name+'-key-{0:D2}.png' -f $pose)),[Drawing.Imaging.ImageFormat]::Png)
  $ga.DrawImageUnscaled($f,$pose*330,$row*300);$f.Dispose()
 }
 $records+=@{state=$set.name;row=$row;scale=$scale;sourceReferenceBounds=$bounds}
 $sheet.Dispose();$row++
}
$atlas.Save((Join-Path $root 'boss-bomber-atlas.png'),[Drawing.Imaging.ImageFormat]::Png);$ga.Dispose();$atlas.Dispose()
@{cell=@(330,300);columns=6;rows=7;renderScale=1.0/3;visibleIdleHeight=270.5/3;anchor=@(165,285);states=$sets;registration=$records}|ConvertTo-Json -Depth 8|Set-Content (Join-Path $root 'animation-manifest.json')
Write-Output 'Prepared 42 Boss Bomber keys on the original 90x90 logical capture canvas at 3x resolution.'


# Shared second boss atlas: Crazy followed by Bomber; keep each cell unchanged.
$combined=[Drawing.Bitmap]::new(2310,3600,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
$gc=[Drawing.Graphics]::FromImage($combined);$gc.Clear([Drawing.Color]::Transparent)
$crazy=[Drawing.Bitmap]::new((Join-Path $root '../boss-crazy/boss-crazy-atlas.png'))
$bomber=[Drawing.Bitmap]::new((Join-Path $root 'boss-bomber-atlas.png'))
for($i=0;$i -lt 84;$i++){
 $source=if($i -lt 42){$crazy}else{$bomber}
 $j=if($i -lt 42){$i}else{$i-42}
 $src=[Drawing.Rectangle]::new(($j%6)*330,[int][Math]::Floor($j/6)*300,330,300)
 $dst=[Drawing.Rectangle]::new(($i%7)*330,[int][Math]::Floor($i/7)*300,330,300)
 $gc.DrawImage($source,$dst,$src,[Drawing.GraphicsUnit]::Pixel)
}
$combined.Save((Join-Path $root 'combined-wide-boss-atlas.png'),[Drawing.Imaging.ImageFormat]::Png)
$gc.Dispose();$combined.Dispose();$crazy.Dispose();$bomber.Dispose()
