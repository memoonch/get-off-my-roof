$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Drawing
$root=Join-Path $PSScriptRoot '../docs/weapons-original'
$sets=@{
 melee=@('NewspaperIcon','BroomIcon','GolfClubIcon','MopIcon','RakeIcon','BaseballBatIcon','PoolStickIcon','NumchuckIcon','ShovelIcon')
 projectile=@('RockIcon','HandFullOfRocksIcon','TennisBallIcon','WaterBalloonIcon','YoYoIcon','VinylRecordIcon','FirecrackerIcon','BaseBallIcon','BoomerangIcon')
}
foreach($kind in $sets.Keys){
 $sheet=[Drawing.Bitmap]::new(960,960)
 $g=[Drawing.Graphics]::FromImage($sheet);$g.Clear([Drawing.Color]::FromArgb(255,34,40,48))
 $g.InterpolationMode=[Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
 $font=[Drawing.Font]::new('Arial',16)
 for($i=0;$i -lt 9;$i++){
  $name=$sets[$kind][$i]
  $folder=Get-ChildItem $root -Directory | Where-Object {$_.Name.EndsWith('_'+$name)} | Select-Object -First 1
  if(!$folder){throw "Missing reference $name"}
  $b=[Drawing.Bitmap]::new((Join-Path $folder.FullName '1.png'))
  $scale=[Math]::Min(260.0/$b.Width,260.0/$b.Height)
  $x=($i%3)*320;$y=[int][Math]::Floor($i/3)*320
  $g.DrawImage($b,[Drawing.RectangleF]::new([single]($x+160-$b.Width*$scale/2),[single]($y+140-$b.Height*$scale/2),[single]($b.Width*$scale),[single]($b.Height*$scale)))
  $g.DrawString(($i+1).ToString()+'. '+$name.Replace('Icon',''),$font,[Drawing.Brushes]::White,$x+12,$y+288)
  $b.Dispose()
 }
 $sheet.Save((Join-Path $root ($kind+'-reference.png')),[Drawing.Imaging.ImageFormat]::Png)
 $g.Dispose();$sheet.Dispose();$font.Dispose()
}
