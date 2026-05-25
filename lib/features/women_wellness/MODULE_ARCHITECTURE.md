# Women Wellness Module — Clean Architecture

Base path: `lib/features/women_wellness/`

## Features

| Feature | Path | Status |
|---------|------|--------|
| authentication | `authentication/` | Mock + remote datasources |
| onboarding | `onboarding/` | Local persistence |
| profile | `profile/` | Complete |
| dashboard | `dashboard/` | Complete |
| calendar | `calendar/` | Complete |
| period_tracking | `period_tracking/` | Complete |
| daily_log | `daily_log/` | Complete |
| symptoms | `symptoms/` | Complete |
| cycle_prediction | `cycle_history/` + `core/helpers/wellness_prediction_helper.dart` | Domain rules |
| cycle_history | `cycle_history/` | Complete |
| reports | `reports/` | Charts via fl_chart |
| insights | `insights/` | Reports-based hub |
| reminders | `reminders/` | Complete |
| notifications | `notifications/` | Privacy-aware previews |
| privacy | `privacy/` | Complete |
| settings | `settings/` | Theme + preferences |
| pdf_report | `pdf_report/` | Complete |
| data_export_import | `data_export_import/` | UI-ready |
| backup_restore | `backup_restore/` | UI-ready |

## Data source switch

`AppEnvironment.isMockMode` → repositories use mock JSON datasources; otherwise remote API placeholders.

## Mock credentials

- Email: `demo@wellness.local`
- Password: `password123`
- OTP (mock): `123456`

## Backend

Contracts and SQL under `backend/women_wellness/<feature>/`.
