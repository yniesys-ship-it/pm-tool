$ErrorActionPreference = 'Continue'
$dir = 'C:\Users\ibuch\pm-tool-deploy\mentor-assets'
Set-Location $dir

$common = 'Generate ONE image with the image_generation tool and SAVE it in the current working directory. It is a course thumbnail card background for a modern EdTech learning platform. Size 640x360 px PNG. Style: clean modern flat illustration, smooth teal gradient base using brand teal hex 00a8c0 to bright cyan hex 18a8c0, with soft rounded abstract shapes and ONE simple large white line-art symbol centered. Airy, premium, 2025 SaaS look. Absolutely NO text, NO letters, NO numbers, NO watermark. '

$items = @(
  @{ f='course-thumb-1.png'; d='Central white line symbol: a target / bullseye with an upward arrow (represents a job-hunting strategy basics course). Teal gradient background.' },
  @{ f='course-thumb-2.png'; d='Central white line symbol: two speech bubbles for a 1on1 conversation / coaching (represents interview and listening skills course). Slightly greener teal 00a8a8 gradient background.' },
  @{ f='course-thumb-3.png'; d='Central white line symbol: a document with a pencil / edit check mark (represents a resume editing method course). Bright cyan 18a8c0 gradient background.' }
)

foreach ($it in $items) {
  $prompt = $common + 'SUBJECT: ' + $it.d + ' Save the file as ' + $it.f + ' now.'
  $log = Join-Path $dir ('gen-' + [System.IO.Path]::GetFileNameWithoutExtension($it.f) + '.log')
  Remove-Item (Join-Path $dir $it.f) -ErrorAction SilentlyContinue
  $null | & codex exec resume --last --dangerously-bypass-approvals-and-sandbox $prompt *> $log
  if (Test-Path (Join-Path $dir $it.f)) { Write-Output ('OK ' + $it.f) } else { Write-Output ('MISS ' + $it.f) }
}
Write-Output 'DONE-THUMBS'
