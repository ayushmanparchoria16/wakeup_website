Add-Type -AssemblyName System.Drawing
$SourceFile = "f:\TeraBoxDownload\Ayushman docs\python projects\interviewbold_landing_page\favicon.png"
$ResDir = "f:\TeraBoxDownload\Ayushman docs\python projects\interviewbold_exe\android_app\android\app\src\main\res"

$Sizes = @{
    "mipmap-mdpi" = 48
    "mipmap-hdpi" = 72
    "mipmap-xhdpi" = 96
    "mipmap-xxhdpi" = 144
    "mipmap-xxxhdpi" = 192
}

foreach ($Folder in $Sizes.Keys) {
    $Size = $Sizes[$Folder]
    $DestPath = Join-Path $ResDir $Folder
    if (-not (Test-Path $DestPath)) { New-Item -ItemType Directory -Path $DestPath -Force | Out-Null }
    
    $SourceImg = [System.Drawing.Image]::FromFile($SourceFile)
    $NewImg = New-Object System.Drawing.Bitmap($Size, $Size)
    $Graphics = [System.Drawing.Graphics]::FromImage($NewImg)
    $Graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $Graphics.DrawImage($SourceImg, 0, 0, $Size, $Size)
    
    $NewImg.Save((Join-Path $DestPath "ic_launcher.png"), [System.Drawing.Imaging.ImageFormat]::Png)
    $NewImg.Save((Join-Path $DestPath "ic_launcher_round.png"), [System.Drawing.Imaging.ImageFormat]::Png)
    
    $Graphics.Dispose()
    $NewImg.Dispose()
    $SourceImg.Dispose()
    
    Write-Host "Generated $Size x $Size in $Folder"
}
