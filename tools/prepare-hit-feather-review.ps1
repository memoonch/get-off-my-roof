$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Drawing
$root=Join-Path $PSScriptRoot '../remaster/assets/effects/hit-feathers'
$sheet=[Drawing.Bitmap]::new(900,480)
$g=[Drawing.Graphics]::FromImage($sheet)
$g.Clear([Drawing.Color]::FromArgb(255,34,40,48))
$g.InterpolationMode=[Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$font=[Drawing.Font]::new('Arial',17)
$small=[Drawing.Font]::new('Arial',12)
$stats=@()
foreach($name in @('feather','impact')){
 $source=[Drawing.Bitmap]::new((Join-Path $root ($name+'-master-v1.png')))
 $left=$source.Width;$top=$source.Height;$right=-1;$bottom=-1;$transparent=0
 for($y=0;$y -lt $source.Height;$y++){for($x=0;$x -lt $source.Width;$x++){
  $a=$source.GetPixel($x,$y).A
  if($a -eq 0){$transparent++}
  if($a -gt 32){$left=[Math]::Min($left,$x);$top=[Math]::Min($top,$y);$right=[Math]::Max($right,$x);$bottom=[Math]::Max($bottom,$y)}
 }}
 if($right -lt $left -or $transparent -eq 0){throw ('Invalid transparent asset: '+$name)}
 $bounds=[Drawing.RectangleF]::new($left,$top,$right-$left+1,$bottom-$top+1)
 $base=if($name -eq 'feather'){0}else{450}
 $title=if($name -eq 'feather'){'Pigeon feather'}else{'Optional hit flash'}
 $g.DrawString($title,$font,[Drawing.Brushes]::White,$base+24,20)
 $g.DrawImage($source,[Drawing.RectangleF]::new($base+75,70,300,300),$bounds,[Drawing.GraphicsUnit]::Pixel)
 $sizes=if($name -eq 'feather'){@(16,24,32,64)}else{@(20,32,48,128)}
 $column=0
 foreach($size in $sizes){
  $output=[Drawing.Bitmap]::new($size,$size,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
  $o=[Drawing.Graphics]::FromImage($output);$o.Clear([Drawing.Color]::Transparent)
  $o.InterpolationMode=[Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $scale=($size-2)/[Math]::Max($bounds.Width,$bounds.Height)
  $w=$bounds.Width*$scale;$h=$bounds.Height*$scale
  $o.DrawImage($source,[Drawing.RectangleF]::new([single](($size-$w)/2),[single](($size-$h)/2),[single]$w,[single]$h),$bounds,[Drawing.GraphicsUnit]::Pixel);$o.Dispose()
  $output.Save((Join-Path $root ($name+'-'+$size+'-v1.png')),[Drawing.Imaging.ImageFormat]::Png)
  # Display at actual pixel size for review; the largest texture is a source sample.
  if($column -lt 3){$g.DrawImageUnscaled($output,$base+55+$column*125,405);$g.DrawString(($size.ToString()+' px'),$small,[Drawing.Brushes]::LightGray,$base+44+$column*125,451)}
  $output.Dispose();$column++
 }
 $stats+=@{asset=$name;width=$source.Width;height=$source.Height;transparentPixels=$transparent;bounds=@($left,$top,$right,$bottom)}
 $source.Dispose()
}
$sheet.Save((Join-Path $root 'design-review-v1.png'),[Drawing.Imaging.ImageFormat]::Png)
$g.Dispose();$sheet.Dispose();$font.Dispose();$small.Dispose()
$stats|ConvertTo-Json -Depth 4|Set-Content (Join-Path $root 'image-check.json')
Write-Output 'Prepared transparent assets and actual-size review samples.'
