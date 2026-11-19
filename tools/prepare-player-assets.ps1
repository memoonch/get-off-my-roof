$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
$assetRoot = Join-Path $PSScriptRoot '../remaster/assets/player'
$frameRoot = Join-Path $assetRoot 'frames'
New-Item -ItemType Directory -Force -Path $frameRoot | Out-Null
$sheet = [Drawing.Bitmap]::new((Join-Path $assetRoot 'player-throw-keyposes-v1.png'))
$atlas = [Drawing.Bitmap]::new(1620,300,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
$atlasGraphics = [Drawing.Graphics]::FromImage($atlas)
$atlasGraphics.Clear([Drawing.Color]::Transparent)
$manifest = @()
$spriteScale = 0.0
for($pose=0; $pose -lt 6; $pose++) {
    $cellX = ($pose % 3)*512
    $cellY = [int][Math]::Floor($pose/3)*512
    $minX=512; $maxX=-1; $minY=512; $maxY=-1
    for($y=0;$y -lt 512;$y++) { for($x=0;$x -lt 512;$x++) {
        if($sheet.GetPixel($cellX+$x,$cellY+$y).A -gt 32) {
            $minX=[Math]::Min($minX,$x);$maxX=[Math]::Max($maxX,$x)
            $minY=[Math]::Min($minY,$y);$maxY=[Math]::Max($maxY,$y)
        }
    }}
    if($maxX -lt 0){throw "Empty pose $pose"}
    if($pose -eq 0){$spriteScale=204.0/($maxY-$minY+1)}
    $feetX=0.0;$feetCount=0
    for($y=$maxY-10;$y -le $maxY;$y++){for($x=$minX;$x -le $maxX;$x++){
        if($sheet.GetPixel($cellX+$x,$cellY+$y).A -gt 100){$feetX+=$x;$feetCount++}
    }}
    $anchorX=$feetX/$feetCount
    $frame=[Drawing.Bitmap]::new(270,300,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g=[Drawing.Graphics]::FromImage($frame)
    $g.Clear([Drawing.Color]::Transparent)
    $g.InterpolationMode=[Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.PixelOffsetMode=[Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $dest=[Drawing.RectangleF]::new([single](135-$anchorX*$spriteScale),[single](240-$maxY*$spriteScale),[single](512*$spriteScale),[single](512*$spriteScale))
    $sourceRect=[Drawing.RectangleF]::new([single]$cellX,[single]$cellY,512,512)
    $g.DrawImage($sheet,$dest,$sourceRect,[Drawing.GraphicsUnit]::Pixel)
    $g.Dispose()
    $file=Join-Path $frameRoot ('throw-key-{0:D2}.png' -f $pose)
    $frame.Save($file,[Drawing.Imaging.ImageFormat]::Png)
    if($pose -eq 0){$frame.Save((Join-Path $frameRoot 'idle-00.png'),[Drawing.Imaging.ImageFormat]::Png)}
    $atlasGraphics.DrawImageUnscaled($frame,$pose*270,0)
    $manifest+=@{pose=$pose;cell=@($cellX,$cellY,512,512);bounds=@($minX,$minY,$maxX,$maxY);sourceFootAnchor=@($anchorX,$maxY);scale=$spriteScale;outputFootAnchor=@(135,240)}
    $frame.Dispose()
}
$atlas.Save((Join-Path $assetRoot 'player-idle-throw-atlas.png'),[Drawing.Imaging.ImageFormat]::Png)
$atlasGraphics.Dispose();$atlas.Dispose();$sheet.Dispose()
$throwMap=@(0,1,1,2,2,3,3,4,4,4,5,5,5,0)
for($f=0;$f -lt $throwMap.Count;$f++){
    Copy-Item -LiteralPath (Join-Path $frameRoot ('throw-key-{0:D2}.png' -f $throwMap[$f])) -Destination (Join-Path $frameRoot ('throw-{0:D2}.png' -f $f))
}
@{frameSize=@(270,300);renderScale=76.0/205;targetVisibleHeight=76;originalIdleVisibleBounds=@(50,76);footAnchor=@(135,240);logicalFootY=20;fps=30;throwFrameMap=$throwMap;poses=$manifest} | ConvertTo-Json -Depth 8 | Set-Content (Join-Path $assetRoot 'animation-manifest.json')
Write-Output 'Prepared six aligned poses, idle sprite, atlas and 14-frame timing map.'
