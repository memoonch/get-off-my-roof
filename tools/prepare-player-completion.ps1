$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Drawing
$root=Join-Path $PSScriptRoot '../remaster/assets/player'
$atlas=[Drawing.Bitmap]::new(1620,2100,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
$ga=[Drawing.Graphics]::FromImage($atlas);$ga.Clear([Drawing.Color]::Transparent)
$old=[Drawing.Bitmap]::new((Join-Path $root 'player-movement-atlas.png'));$ga.DrawImageUnscaled($old,0,0);$old.Dispose()
$sets=@(@{name='swing';row=3;map=@(0,1,1,2,2,3,3,4,4,5,5,0)},@{name='hit';row=4;map=@(0,1,2,3,3,4,4,5,5)},@{name='wipe';row=5;map=@(0,1,1,1,2,2,2,3,3,3,3,3,3,4,4,4,5,5,0)},@{name='death';row=6;map=@(0,1,1,2,2,3,4,5,5)})
$records=@()
foreach($set in $sets){
 $source='player-'+$set.name+'-keyposes-v1.png'
 if($set.name -eq 'swing'){$source='player-swing-keyposes-v2.png'}
 $sheet=[Drawing.Bitmap]::new((Join-Path $root $source))
 if($sheet.Width -ne 1536 -or $sheet.Height -ne 1024){throw 'Unexpected source sheet dimensions'}
 $scale=0.0;$baseline=0
 for($pose=0;$pose -lt 6;$pose++){
  $sx=($pose%3)*512;$sy=[int][Math]::Floor($pose/3)*512
  $minY=512;$maxY=-1
  for($y=0;$y -lt 512;$y++){for($x=0;$x -lt 512;$x++){
   $c=$sheet.GetPixel($sx+$x,$sy+$y)
   if($c.A -le 24 -or $x -lt 3 -or $x -gt 508 -or $y -lt 3 -or $y -gt 508){$sheet.SetPixel($sx+$x,$sy+$y,[Drawing.Color]::Transparent)}
   elseif($c.A -gt 32){$minY=[Math]::Min($minY,$y);$maxY=[Math]::Max($maxY,$y)}
  }}
  if($pose -eq 0){$scale=204.0/($maxY-$minY+1);$baseline=$maxY}
  $anchorY=$baseline
  if($set.name -eq 'death'){$anchorY=$maxY}
  $frame=[Drawing.Bitmap]::new(270,300,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
  $g=[Drawing.Graphics]::FromImage($frame);$g.Clear([Drawing.Color]::Transparent)
  $g.InterpolationMode=[Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic;$g.PixelOffsetMode=[Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $dest=[Drawing.RectangleF]::new([single](135-256*$scale),[single](240-$anchorY*$scale),[single](512*$scale),[single](512*$scale))
  $g.DrawImage($sheet,$dest,[Drawing.RectangleF]::new($sx,$sy,512,512),[Drawing.GraphicsUnit]::Pixel);$g.Dispose()
  $frame.Save((Join-Path $root ('frames/'+$set.name+'-key-{0:D2}.png' -f $pose)),[Drawing.Imaging.ImageFormat]::Png)
  $ga.DrawImageUnscaled($frame,$pose*270,$set.row*300);$frame.Dispose()
  $records+=@{state=$set.name;pose=$pose;scale=$scale;sourceRootX=256;sourceBaseline=$anchorY}
 }
 for($f=0;$f -lt $set.map.Count;$f++){Copy-Item (Join-Path $root ('frames/'+$set.name+'-key-{0:D2}.png' -f $set.map[$f])) (Join-Path $root ('frames/'+$set.name+'-{0:D2}.png' -f $f))}
 $sheet.Dispose()
}
$atlas.Save((Join-Path $root 'player-atlas.png'),[Drawing.Imaging.ImageFormat]::Png);$ga.Dispose();$atlas.Dispose()
@{columns=6;rows=7;frameSize=@(270,300);states=$sets;registration=$records}|ConvertTo-Json -Depth 8|Set-Content (Join-Path $root 'completion-manifest.json')
Write-Output 'Prepared swing/hit/wipe/death frames and combined 42-pose atlas.'
