$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Drawing
$root=Join-Path $PSScriptRoot '../remaster/assets/weapons'
New-Item -ItemType Directory -Force (Join-Path $root 'runtime') | Out-Null
function AlphaBounds($b){
 $l=$b.Width;$t=$b.Height;$r=-1;$bottom=-1
 for($y=0;$y -lt $b.Height;$y++){for($x=0;$x -lt $b.Width;$x++){if($b.GetPixel($x,$y).A -gt 32){$l=[Math]::Min($l,$x);$r=[Math]::Max($r,$x);$t=[Math]::Min($t,$y);$bottom=[Math]::Max($bottom,$y)}}}
 if($r -lt $l){throw 'Empty image'}
 return [Drawing.Rectangle]::new($l,$t,$r-$l+1,$bottom-$t+1)
}
$registrations=Get-Content (Join-Path $root 'original-registrations.json') -Raw | ConvertFrom-Json
$records=@()
foreach($asset in $registrations.assets){
 $file=if($asset.kind -eq 'melee' -and $asset.name -eq 'nunchucks'){'gameplay/nunchucks-extended-master-v1.png'}else{'icons/'+$asset.name+'-v1.png'}
 $source=[Drawing.Bitmap]::new((Join-Path $root $file))
 if($asset.kind -eq 'melee' -and $asset.name -ne 'nunchucks'){
  $rotated=[Drawing.Bitmap]::new(768,768,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
  $gr=[Drawing.Graphics]::FromImage($rotated);$gr.Clear([Drawing.Color]::Transparent)
  $gr.InterpolationMode=[Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $gr.TranslateTransform(384,384);$gr.RotateTransform(45)
  $gr.DrawImage($source,-256,-256,512,512);$gr.Dispose();$source.Dispose();$source=$rotated
 }
 $bounds=AlphaBounds $source
 $logicalWidth=($asset.bounds[1]-$asset.bounds[0])/20.0
 $logicalHeight=($asset.bounds[3]-$asset.bounds[2])/20.0
 $factor=if($asset.kind -eq 'icon'){[Math]::Min(4,192/[Math]::Max($logicalWidth,$logicalHeight))}else{3}
 $width=[Math]::Max(1,[int][Math]::Ceiling($logicalWidth*$factor));$height=[Math]::Max(1,[int][Math]::Ceiling($logicalHeight*$factor))
 $bitmap=[Drawing.Bitmap]::new($width,$height,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
 $g=[Drawing.Graphics]::FromImage($bitmap);$g.Clear([Drawing.Color]::Transparent)
 $g.InterpolationMode=[Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
 $scale=[Math]::Min($width/[double]$bounds.Width,$height/[double]$bounds.Height)
 $destination=[Drawing.RectangleF]::new([single](($width-$bounds.Width*$scale)/2),[single](($height-$bounds.Height*$scale)/2),[single]($bounds.Width*$scale),[single]($bounds.Height*$scale))
 # Melee spans must start at the original grip and end at the original tip.
 # Keep the extended nunchucks' thin profile centered on their original axis.
 if($asset.kind -eq 'melee' -and $asset.name -ne 'nunchucks'){$destination=[Drawing.RectangleF]::new(0,0,$width,$height)}
 $g.DrawImage($source,$destination,[Drawing.RectangleF]::new($bounds.X,$bounds.Y,$bounds.Width,$bounds.Height),[Drawing.GraphicsUnit]::Pixel);$g.Dispose();$source.Dispose()
 $prefix='runtime/'+$asset.id+'-'+$asset.name
 $bitmap.Save((Join-Path $root ($prefix+'.png')),[Drawing.Imaging.ImageFormat]::Png)
 $bytes=[byte[]]::new($width*$height*4);$p=0
 for($y=0;$y -lt $height;$y++){for($x=0;$x -lt $width;$x++){
  $c=$bitmap.GetPixel($x,$y);$a=if($c.A -le 24){0}else{[int]$c.A}
  $bytes[$p++]=$a;$bytes[$p++]=[byte][Math]::Round($c.R*$a/255.0);$bytes[$p++]=[byte][Math]::Round($c.G*$a/255.0);$bytes[$p++]=[byte][Math]::Round($c.B*$a/255.0)
 }}
 [IO.File]::WriteAllBytes((Join-Path $root ($prefix+'.argb')),$bytes);$bitmap.Dispose()
 $records+=@{id=$asset.id;name=$asset.name;kind=$asset.kind;bounds=$asset.bounds;frames=$asset.frames;width=$width;height=$height;raw=$prefix+'.argb';png=$prefix+'.png'}
}
@{assets=$records;registration='Original symbol-local twip bounds, frame counts and labels';alpha='premultiplied ARGB for DefineBitsLossless2'}|ConvertTo-Json -Depth 6|Set-Content (Join-Path $root 'integration-manifest.json')
Write-Output ('Prepared '+$records.Count+' registered weapon symbols.')
