$ErrorActionPreference = 'Continue'
$dir = 'C:\Users\ibuch\pm-tool-deploy\mentor-assets'
Set-Location $dir

$common = 'Generate ONE image with the image_generation tool and SAVE it in the current working directory. It must be a single modern flat LINE ICON, rounded stroke, medium weight, centered, on a FULLY TRANSPARENT background (alpha, no card, no circle behind it, no shadow). Icon color is teal hex 00a8c0. Clean minimal 2025 SaaS UI icon style. Absolutely NO text, NO letters, NO numbers. 256x256 px PNG. '

$icons = @(
  @{ f='ic-logo.png';     d='Actually THIS one is the app brand LOGO MARK, not a line icon: a solid rounded-square tile filled with a smooth teal gradient from 00a8c0 to 18a8c0, with a simple abstract white letter-C-like arc mark centered in it. 256x256 PNG, transparent OUTSIDE the rounded square.' },
  @{ f='ic-home.png';     d='A simple home / dashboard icon (a house or a 2x2 grid of rounded squares).' },
  @{ f='ic-students.png'; d='A students icon: two simple people / user silhouettes, rounded.' },
  @{ f='ic-tasks.png';    d='A tasks icon: a clipboard with a check mark.' },
  @{ f='ic-events.png';   d='A calendar / events icon with a small dot marking a date.' },
  @{ f='ic-analytics.png';d='An analytics icon: a simple bar chart with a rising trend line.' }
)

$first = $true
foreach ($ic in $icons) {
  $prompt = $common + 'SUBJECT: ' + $ic.d + ' Save the file as ' + $ic.f + ' now.'
  $log = Join-Path $dir ('gen-' + [System.IO.Path]::GetFileNameWithoutExtension($ic.f) + '.log')
  Remove-Item (Join-Path $dir $ic.f) -ErrorAction SilentlyContinue
  if ($first) {
    $null | & codex exec resume --last --dangerously-bypass-approvals-and-sandbox $prompt *> $log
    $first = $false
  } else {
    $null | & codex exec resume --last --dangerously-bypass-approvals-and-sandbox $prompt *> $log
  }
  if (Test-Path (Join-Path $dir $ic.f)) { Write-Output ('OK ' + $ic.f) } else { Write-Output ('MISS ' + $ic.f) }
}
Write-Output 'DONE'
