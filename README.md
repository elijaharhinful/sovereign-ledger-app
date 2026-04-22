# Sovereign Ledger 💼

> A personal finance tracking mobile app built with Flutter for the HNG Mobile Track Stage 2 Task.

---

## 📱 Features

| Feature | Description |
|---|---|
| **Transaction Management** | Log income and expenses, categorised by type (food, transport, salary, etc.) |
| **Budget Tracking** | Set per-category budgets with real-time utilisation tracking (Healthy / On Track / At Limit / Over Limit) |
| **Financial Dashboard** | Live balance, spending trend chart, allocation cards, savings breakdown |
| **Recurring Transactions** | Set up daily / weekly / monthly auto-posting transactions |
| **Financial Insights** | Bar charts (spending velocity), donut chart (allocation), monthly burn rate, smart suggestions |
| **Liveness Verification** | Biometric facial liveness check guards access to the dashboard |
| **Data Persistence** | All data stored locally using Hive — no backend required |
| **CSV Export**| Export all transactions to a `.csv` file |
| **Currency Formatting** | Supports USD, EUR, GBP, GHS, NGN, JPY and more |

---

## 🏗️ Architecture

This app uses a **feature-first** architecture with four clean layers per feature:

```
feature/
├── data/           # Repositories, Hive adapters
├── domain/         # Immutable models, enums, business rules
├── application/    # Services, Riverpod providers
└── presentation/   # Screens, widgets
```

**Data flow:**
```
Presentation → Application → Data
      ↑                         |
      └──────── Domain ─────────┘
```

**State management:** Flutter Riverpod (`StateNotifierProvider` + `Provider`)

**Routing:** GoRouter with an auth guard that redirects unauthenticated users to the liveness screen.

---

## 🎨 Brand Palette

| Token | Hex | Usage |
|---|---|---|
| `primaryDark` | `#013380` | Primary CTA, nav active |
| `primary` | `#0949A4` | Secondary blue |
| `slateBlue` | `#94A3B8` | Labels, inactive |
| `mint` | `#4EDEA3` | Healthy status, accent |
| `danger` | `#BA1A1A` | Over-limit, error |
| `forest` | `#00593C` | Positive / income |
| `periwinkle` | `#86A5CE` | Chart fill |
| `surface` | `#E0E3E5` | Backgrounds, progress track |

---

## 📦 Key Dependencies

```yaml
flutter_riverpod: ^2.4.9     # State management
go_router: ^13.2.0           # Routing + auth guard
hive_flutter: ^1.1.0         # Local NoSQL storage
fl_chart: ^0.67.0            # Line, bar, donut charts
facial_liveness_verification # Biometric liveness check
intl: ^0.19.0                # Currency & date formatting
csv: ^6.0.0                  # CSV export
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `>=3.0.0`
- Dart `>=3.0.0`
- Android SDK 21+ / iOS 12+

### Setup

```bash
# Clone the repo
git clone https://github.com/your-username/sovereign_ledger.git
cd sovereign_ledger

# Install dependencies
flutter pub get

# Run code generation (Hive adapters + Riverpod generators)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Build APK (release)

```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Build IPA (iOS)

```bash
flutter build ipa
# Output: build/ios/archive/Runner.xcarchive
```

---

## 📂 Project Structure

```
lib/
├── main.dart                     # Entry point, Hive init, ProviderScope
├── app.dart                      # MaterialApp.router + theme
└── src/
    ├── features/
    │   ├── auth/                 # Liveness verification + auth guard
    │   ├── transactions/         # Add, view, delete transactions
    │   ├── budgets/              # Budget CRUD + utilisation logic
    │   ├── dashboard/            # Overview screen
    │   ├── insights/             # Charts + smart suggestions
    │   ├── recurring/            # Recurring transaction engine
    │   └── settings/             # Profile, security, export
    ├── common_widgets/           # Shared UI components
    ├── constants/                # Colors, text styles, sizes
    ├── routing/                  # GoRouter config
    └── utils/                    # Currency & date formatters
```

---

## 🔐 Security

The app uses the `facial_liveness_verification` package to:
1. Present a camera frame with real-time prompts
2. Detect passive liveness (blink, smile)
3. Cross-reference with encryption check
4. Grant or deny dashboard access

The GoRouter `redirect` function enforces this — unauthenticated navigation attempts are always intercepted.

---

## 📊 Data Persistence

All data is stored in Hive boxes on the device:

| Box | Model | typeId |
|---|---|---|
| `transactions` | `Transaction` | 0 |
| `budgets` | `Budget` | 3 |
| `recurring` | `RecurringTransaction` | 4 |
| `settings` | `AppSettings` | 6 |

Data survives app restarts and device reboots automatically.

---

## 📤 Data Export

Navigate to **Settings → Export Data** to export all transactions as a `.csv` file saved to the app documents directory.

---

*Sovereign Ledger — HNG Mobile Track Stage 2 | Feature-first Flutter architecture*
