For Flutter projects:
- Do not run full `flutter analyze` automatically.
- Analyze only touched files unless I explicitly ask full analysis.
- Prefer:
  `dart format <changed-files>`
  `flutter analyze <changed-files>`
- If Flutter command hangs more than 3 minutes, stop it and report.
- Do not run `/review` while another task is active.