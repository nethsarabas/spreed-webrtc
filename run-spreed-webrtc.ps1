# Move to the script's directory (main spreed-webrtc)
Set-Location -Path $PSScriptRoot

# Copy config if needed
if (!(Test-Path .\server.conf) -and (Test-Path .\server.conf.in)) {
    Copy-Item .\server.conf.in .\server.conf
    Write-Host "Copied server.conf.in to server.conf"
}

# Try to run the native binary
if (Test-Path .\spreed-webrtc-server) {
    Write-Host "Running spreed-webrtc-server binary..."
    .\spreed-webrtc-server -c server.conf
} else {
    Write-Host "spreed-webrtc-server binary not found. Running with Docker instead..."
    docker run --rm --name my-spreed-webrtc -p 8080:8080 -p 8443:8443 -v "${PWD}:/srv/extra" -i -t spreed/webrtc
}
