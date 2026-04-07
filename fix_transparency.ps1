Add-Type -AssemblyName System.Drawing
$Path = "f:\TeraBoxDownload\Ayushman docs\python projects\interviewbold_landing_page\favicon.png"

# Load the image
$bmp = New-Object System.Drawing.Bitmap($Path)
$newBmp = New-Object System.Drawing.Bitmap($bmp.Width, $bmp.Height)
$g = [System.Drawing.Graphics]::FromImage($newBmp)

# Create a circular path
$path = New-Object System.Drawing.Drawing2D.GraphicsPath
$path.AddEllipse(0, 0, $bmp.Width, $bmp.Height)

# Set the clipping region to the circle
$g.SetClip($path)
$g.Clear([System.Drawing.Color]::Transparent)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

# Draw the original image into the circular clip
$g.DrawImage($bmp, 0, 0)

# Clean up
$g.Dispose()
$bmp.Dispose()

# Save the rounded transparent image
$newBmp.Save($Path, [System.Drawing.Imaging.ImageFormat]::Png)
$newBmp.Dispose()

Write-Host "Forced circular transparency on favicon.png"
