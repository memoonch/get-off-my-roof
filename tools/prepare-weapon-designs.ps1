$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Drawing
$root=Join-Path $PSScriptRoot '../remaster/assets/weapons'
$sets=@{
 melee=@('newspaper','broom','golf-club','mop','rake','baseball-bat','pool-cue','nunchucks','shovel')
 projectile=@('rock','handful-of-rocks','tennis-ball','water-balloon','yo-yo','vinyl-record','firecracker','baseball','boomerang')
}
$manifest=@()
foreach($kind in @('melee','projectile')){
 $sheet=[Drawing.Bitmap]::new((Join-Path $root ($kind+'-design-sheet-v1.png')))
 if($sheet.Width -ne $sheet.Height){throw 'Expected square 3x3 sheet'}
 for($i=0;$i -lt 9;$i++){
  $col=$i%3;$row=[int][Math]::Floor($i/3)
  $x=[int][Math]::Round($col*$sheet.Width/3);$y=[int][Math]::Round($row*$sheet.Height/3)
  $right=[int][Math]::Round(($col+1)*$sheet.Width/3);$bottom=[int][Math]::Round(($row+1)*$sheet.Height/3)
  $source=$sheet.Clone([Drawing.Rectangle]::new($x,$y,$right-$x,$bottom-$y),[Drawing.Imaging.PixelFormat]::Format32bppArgb)
  for($sy=0;$sy -lt $source.Height;$sy++){for($sx=0;$sx -lt $source.Width;$sx++){if($source.GetPixel($sx,$sy).A -le 24){$source.SetPixel($sx,$sy,[Drawing.Color]::Transparent)}}}
  $icon=[Drawing.Bitmap]::new(512,512,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
  $g=[Drawing.Graphics]::FromImage($icon);$g.Clear([Drawing.Color]::Transparent)
  $g.InterpolationMode=[Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.DrawImage($source,[Drawing.Rectangle]::new(0,0,512,512))
  $file='icons/'+$sets[$kind][$i]+'-v1.png'
  $icon.Save((Join-Path $root $file),[Drawing.Imaging.ImageFormat]::Png)
  $manifest+=@{id=$sets[$kind][$i];family=$kind;file=$file;sheetRow=$row;sheetColumn=$col;width=512;height=512;status='design-review'}
  $g.Dispose();$icon.Dispose();$source.Dispose()
 }
 $sheet.Dispose()
}
@{version=1;generatedWith='built-in imagegen';status='Design review; gameplay registration and integration pending';assets=$manifest}|ConvertTo-Json -Depth 5|Set-Content (Join-Path $root 'manifest.json')
Write-Output 'Prepared 18 separate transparent 512x512 weapon design assets.'
