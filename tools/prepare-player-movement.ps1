$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Drawing
$root=Join-Path $PSScriptRoot '../remaster/assets/player'
$manifest=Get-Content (Join-Path $root 'animation-manifest.json') -Raw | ConvertFrom-Json
$scale=[double]$manifest.poses[0].scale
$atlas=[Drawing.Bitmap]::new(1620,900,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
$gAtlas=[Drawing.Graphics]::FromImage($atlas)
$gAtlas.Clear([Drawing.Color]::Transparent)
$old=[Drawing.Bitmap]::new((Join-Path $root 'player-idle-throw-atlas.png'))
$gAtlas.DrawImageUnscaled($old,0,0);$old.Dispose()
$sets=@(@{name='walk';row=1;baseline=480;map=@(0,0,1,1,2,2,3,3,4,4,5,5,0)},@{name='jump';row=2;baseline=470;map=@(0,0,1,1,2,2,3,3,3,4,4,5,5)})
$records=@()
foreach($set in $sets){
 $sheet=[Drawing.Bitmap]::new((Join-Path $root ('player-'+$set.name+'-keyposes-v1.png')))
 if($sheet.Width -ne 1536 -or $sheet.Height -ne 1024){throw 'Unexpected sheet grid'}
 for($pose=0;$pose -lt 6;$pose++){
  $sx=($pose%3)*512;$sy=[int][Math]::Floor($pose/3)*512
  $top=512
  for($y=0;$y -lt 512;$y++){for($x=0;$x -lt 512;$x++){if($sheet.GetPixel($sx+$x,$sy+$y).A -gt 32){$top=[Math]::Min($top,$y)}}}
  $headMin=512;$headMax=0
  for($y=$top;$y -lt [Math]::Min(512,$top+95);$y++){for($x=0;$x -lt 512;$x++){
   $c=$sheet.GetPixel($sx+$x,$sy+$y)
   if($c.A -gt 150 -and $c.R -gt 150 -and $c.G -gt 80 -and $c.R -gt $c.G*1.12){$headMin=[Math]::Min($headMin,$x);$headMax=[Math]::Max($headMax,$x)}
  }}
  if($headMin -ge $headMax){throw 'Head registration failed'}
  $center=($headMin+$headMax)/2.0
  $frame=[Drawing.Bitmap]::new(270,300,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
  $g=[Drawing.Graphics]::FromImage($frame);$g.Clear([Drawing.Color]::Transparent)
  $g.InterpolationMode=[Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic;$g.PixelOffsetMode=[Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $dest=[Drawing.RectangleF]::new([single](135-$center*$scale),[single](240-$set.baseline*$scale),[single](512*$scale),[single](512*$scale))
  $g.DrawImage($sheet,$dest,[Drawing.RectangleF]::new($sx,$sy,512,512),[Drawing.GraphicsUnit]::Pixel);$g.Dispose()
  $frame.Save((Join-Path $root ('frames/'+$set.name+'-key-{0:D2}.png' -f $pose)),[Drawing.Imaging.ImageFormat]::Png)
  $gAtlas.DrawImageUnscaled($frame,$pose*270,$set.row*300);$frame.Dispose()
  $records+=@{state=$set.name;pose=$pose;sourceHeadCenter=$center;sourceBaseline=$set.baseline;scale=$scale}
 }
 for($f=0;$f -lt $set.map.Count;$f++){Copy-Item (Join-Path $root ('frames/'+$set.name+'-key-{0:D2}.png' -f $set.map[$f])) (Join-Path $root ('frames/'+$set.name+'-{0:D2}.png' -f $f))}
 $sheet.Dispose()
}
$atlas.Save((Join-Path $root 'player-movement-atlas.png'),[Drawing.Imaging.ImageFormat]::Png);$gAtlas.Dispose();$atlas.Dispose()
@{columns=6;rows=3;frameSize=@(270,300);states=@{throw=@(0,1,1,2,2,3,3,4,4,4,5,5,5,0);walk=$sets[0].map;jump=$sets[1].map};registration=$records}|ConvertTo-Json -Depth 8|Set-Content (Join-Path $root 'movement-manifest.json')
Write-Output 'Prepared walk/jump PNG frames and combined 18-pose atlas.'
