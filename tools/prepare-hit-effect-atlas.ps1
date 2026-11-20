$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Drawing
$root=Join-Path $PSScriptRoot '../remaster/assets/effects/hit-feathers'
$atlas=[Drawing.Bitmap]::new(128,64,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g=[Drawing.Graphics]::FromImage($atlas);$g.Clear([Drawing.Color]::Transparent)
$g.InterpolationMode=[Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
foreach($name in @('feather','impact')){
 $b=[Drawing.Bitmap]::new((Join-Path $root ($name+'-master-v1.png')))
 if($name -eq 'feather'){
  $rot=[Drawing.Bitmap]::new(1900,1900,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
  $r=[Drawing.Graphics]::FromImage($rot);$r.Clear([Drawing.Color]::Transparent)
  $r.InterpolationMode=[Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $r.TranslateTransform(950,950);$r.RotateTransform(45)
  $r.DrawImage($b,-$b.Width/2,-$b.Height/2,$b.Width,$b.Height);$r.Dispose();$b.Dispose();$b=$rot
 }
 $l=$b.Width;$t=$b.Height;$rr=-1;$bb=-1
 for($y=0;$y -lt $b.Height;$y++){for($x=0;$x -lt $b.Width;$x++){if($b.GetPixel($x,$y).A -gt 32){$l=[Math]::Min($l,$x);$t=[Math]::Min($t,$y);$rr=[Math]::Max($rr,$x);$bb=[Math]::Max($bb,$y)}}}
 $dest=if($name -eq 'feather'){[Drawing.RectangleF]::new(0,0,64,32)}else{[Drawing.RectangleF]::new(64,0,64,64)}
 $g.DrawImage($b,$dest,[Drawing.RectangleF]::new($l,$t,$rr-$l+1,$bb-$t+1),[Drawing.GraphicsUnit]::Pixel)
 $b.Dispose()
}
$g.Dispose();$atlas.Save((Join-Path $root 'hit-effect-atlas-v1.png'),[Drawing.Imaging.ImageFormat]::Png);$atlas.Dispose()
Write-Output 'Prepared 128 x 64 shared hit-effect atlas.'
