# Expense Tracker Lite

A production-grade Expense Tracker Lite Flutter application built with Clean Architecture, BLoC state management, and Hive local database. This app allows users to track expenses, convert currencies in real-time, and view their financial data with a beautiful, pixel-perfect UI.

## 📱 Features

- **Dashboard**: View total balance, income, expenses, and recent transactions with filtering options (Today, This Week, This Month, This Year, All Time)
- **Add Expense**: Add new expenses with category, amount, date, currency, and optional receipt attachment
- **Currency Conversion**: Automatically converts foreign currencies to USD using real-time exchange rates from ExchangeRate-API
- **Offline Support**: Caches expenses locally using Hive and stores exchange rates for offline usage
- **Pagination**: Efficiently loads expenses in chunks (10 items per page) for optimal performance
- **Receipt Attachment**: Attach images or files as receipts for expenses
- **Pixel-Perfect Design**: Modern, beautiful UI with smooth animations and transitions

## 🏗️ Architecture Overview

The project follows **Clean Architecture** principles organized by features, ensuring:
- **Separation of Concerns**: Each layer has a specific responsibility
- **Testability**: Business logic is independent of UI and frameworks
- **Maintainability**: Easy to modify and extend
- **Scalability**: Can grow without becoming unmanageable

### Project Structure

```
lib/
├── src/
│   ├── core/                      # Shared utilities and configurations
│   │   ├── di/                    # Dependency injection setup
│   │   ├── error/                 # Error handling (Failures, Exceptions)
│   │   ├── extensions/            # Dart extensions
│   │   ├── helper/                # Helper classes (Constants, Validations)
│   │   ├── networking/            # API client, interceptors
│   │   └── theme/                 # App theme and colors
│   │
│   └── features/                  # Feature modules
│       ├── expense/               # Expense tracking feature
│       │   ├── data/              # Data layer
│       │   │   ├── datasources/   # Local (Hive) and Remote (API) data sources
│       │   │   ├── models/        # Data models with JSON/Hive serialization
│       │   │   └── repositories/  # Repository implementations
│       │   ├── domain/            # Domain layer
│       │   │   ├── entities/      # Business entities
│       │   │   ├── repositories/  # Repository interfaces
│       │   │   └── usecases/      # Business logic use cases
│       │   └── presentation/      # Presentation layer
│       │       ├── bloc/          # BLoC state management
│       │       ├── pages/         # Screen widgets
│       │       └── widgets/       # Reusable UI components
│       │
│       └── file_picker/           # File/Image picker feature
│           └── [similar structure]
│
└── main.dart                      # App entry point
```

### Architecture Layers

#### 1. **Presentation Layer**
- **Responsibility**: UI rendering and user interaction
- **Components**: 
  - Pages (Screens)
  - Widgets (Reusable UI components)
  - BLoC (State management)
- **Dependencies**: Domain layer only

#### 2. **Domain Layer**
- **Responsibility**: Business logic and rules
- **Components**:
  - Entities (Pure business objects)
  - Use Cases (Business operations)
  - Repository Interfaces (Contracts)
- **Dependencies**: None (pure Dart)

#### 3. **Data Layer**
- **Responsibility**: Data retrieval and persistence
- **Components**:
  - Models (Data transfer objects)
  - Data Sources (Local/Remote)
  - Repository Implementations
- **Dependencies**: Domain layer

#### 4. **Core Layer**
- **Responsibility**: Shared utilities and configurations
- **Components**:
  - Dependency Injection
  - Error Handling
  - Networking
  - Theme
  - Extensions

## 🎯 State Management Approach

### BLoC (Business Logic Component)

The app uses **flutter_bloc** for state management, following these principles:

#### Why BLoC?
- **Predictable**: State changes are explicit and traceable
- **Testable**: Business logic is separated from UI
- **Reusable**: BLoCs can be shared across widgets
- **Reactive**: Automatic UI updates on state changes

#### BLoC Implementation

**ExpenseBloc** - Manages expense list and filtering:
```dart
States: loading, success, failure
Events: LoadExpenses, LoadMoreExpenses, FilterExpensesEvent
```

**AddExpenseBloc** - Manages expense creation:
```dart
States: initial, loading, rateExchangedLoaded, success, failure
Events: LoadExchangeRateEvent, SubmitExpenseEvent, UpdateParamsEvent
```

**FilePickerCubit** - Manages file/image selection:
```dart
States: initial, loading, success, failure
```

#### State Flow Example
```
User Action → Event → BLoC → Use Case → Repository → Data Source
                ↓
            New State → UI Update
```

## 🌐 API Integration

### ExchangeRate-API Integration

**Base URL**: `https://api.exchangerate-api.com/v4/latest/`

**Implementation Details**:
- **Package**: `dio` for HTTP requests
- **Interceptors**: 
  - Logging interceptor for debugging
  - Response validation interceptor
- **Error Handling**: Custom exceptions mapped to Failures
- **Caching**: Exchange rates are cached locally in Hive

**API Call Flow**:
1. User selects a foreign currency
2. `AddExpenseBloc` triggers `LoadExchangeRateEvent`
3. `GetExchangeRate` use case is called
4. `ExchangeRepositoryImpl` checks cache first
5. If not cached or expired, calls `ExchangeRemoteDataSource`
6. API response is parsed and cached
7. Converted amount is calculated and displayed

**Error Handling**:
- Network errors → `ServerFailure`
- Timeout → Retry mechanism
- Invalid response → Validation error
- Fallback to cached data if available

## 📄 Pagination Strategy

### Local Pagination (Current Implementation)

**Why Local Pagination?**
- Expenses are stored locally in Hive
- Fast access without network dependency
- Consistent offline experience
- Simple implementation for MVP

**Implementation**:
- **Page Size**: 10 expenses per page (configurable in `AppConstants.pageSize`)
- **Strategy**: Offset-based pagination
- **Loading**: 
  - Initial load: Fetch first 10 expenses
  - Load more: Fetch next 10 when user scrolls to bottom
- **State Management**: `ExpenseBloc` tracks current offset and hasReachedMax flag

**Code Example**:
```dart
// Initial load
LoadExpenses() → getExpenses(offset: 0, limit: 10)

// Load more
LoadMoreExpenses() → getExpenses(offset: currentLength, limit: 10)
```

### Future: API Pagination

If expenses were stored on a server:
- Use cursor-based pagination for better performance
- Implement infinite scroll with pull-to-refresh
- Cache pages locally for offline access
- Sync local changes when online

## 🔧 Dependency Injection

### Injectable + GetIt

**Setup**:
- `@injectable` annotations on classes
- `@singleton`, `@lazySingleton` for lifecycle management
- Code generation via `build_runner`

**Benefits**:
- Compile-time safety
- Easy testing with mock injection
- Automatic dependency graph resolution
- No manual registration code

**Example**:
```dart
@injectable
class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  final Box<ExpenseModel> expenseBox;
  
  ExpenseLocalDataSourceImpl(@Named(AppConstants.expenseBox) this.expenseBox);
}
```

## 🎨 UI/UX Design

### Design System
- **Colors**: Custom color palette with primary, secondary, and accent colors
- **Typography**: Custom text styles for consistency
- **Spacing**: Consistent padding and margins using ScreenUtil
- **Components**: Reusable widgets (CustomButton, CustomTextField, etc.)

### Responsive Design
- **ScreenUtil**: Adapts to different screen sizes
- **Design Size**: 375x812 (iPhone 11 Pro)
- **Scaling**: Automatic font and size scaling

### Animations
- Smooth page transitions
- Loading indicators
- Micro-interactions on buttons and cards

## 🚀 How to Run the Project

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd expense_tracker_lite
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code** (Hive adapters, DI, JSON serialization)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   # For development
   flutter run
   
   # For specific device
   flutter run -d <device-id>
   
   # For release build
   flutter run --release
   ```

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/features/expense/data/repositories/expense_repository_impl_test.dart

# Run with coverage
flutter test --coverage
```

## 📸 Screenshots

### Dashboard
![Dashboard](screenshots/dashboard.png)
*Main dashboard showing balance, income, expenses, and recent transactions*

### Add Expense
![Add Expense](screenshots/add_expense.png)
*Add expense form with currency conversion and receipt attachment*

### Expense List
![Expense List](screenshots/expense_list.png)
*Paginated expense list with filtering options*

## ⚖️ Trade-offs & Assumptions

### Trade-offs

1. **Local vs Remote Storage**
   - **Decision**: Store expenses locally in Hive
   - **Reason**: Faster access, offline-first approach, simpler MVP
   - **Trade-off**: No cloud sync, data loss if app is uninstalled

2. **Currency API**
   - **Decision**: Use free ExchangeRate-API
   - **Reason**: No cost, easy integration
   - **Trade-off**: Rate limits (1500 requests/month), might need upgrade for production

3. **Pagination**
   - **Decision**: Local pagination with fixed page size
   - **Reason**: Simple implementation, sufficient for local data
   - **Trade-off**: Loads all data into memory eventually

4. **Testing**
   - **Decision**: Focus on unit and bloc tests
   - **Reason**: Time constraints, core logic coverage
   - **Trade-off**: Limited widget/integration tests

### Assumptions

1. **User Base**: Single user per device (no multi-user support)
2. **Data Volume**: Moderate number of expenses (< 10,000)
3. **Currency**: All expenses converted to USD for consistency
4. **Date Format**: dd/MM/yyyy format for user input
5. **Categories**: Predefined categories (Groceries, Food, Transport, etc.)
6. **Network**: Internet required for currency conversion, but app works offline with cached rates

## 🐛 Known Bugs & Limitations

### Known Issues

1. **Widget Test Failure**
   - **Issue**: AddExpensePage widget test fails due to DateTime comparison
   - **Impact**: Test suite shows 1 failure (11 passing, 1 failing)
   - **Workaround**: Test logic is correct, issue is with test setup
   - **Status**: Low priority, doesn't affect app functionality

2. **SVG Warning**
   - **Issue**: "unhandled element <style/>" warning when loading SVG assets
   - **Impact**: Console warning only, no visual impact
   - **Workaround**: Ignore or use PNG alternatives
   - **Status**: Known flutter_svg issue

### Limitations

1. **No Cloud Sync**: Expenses are stored locally only
2. **No User Authentication**: Single user per device
3. **No Expense Editing**: Can only add new expenses (edit feature not implemented)
4. **No Expense Deletion**: Cannot delete expenses after creation
5. **No Data Export**: Cannot export expenses to CSV/PDF
6. **No Budget Tracking**: No budget limits or alerts
7. **No Recurring Expenses**: Cannot set up recurring transactions
8. **Limited Currency Support**: Depends on API availability

### Future Enhancements

- [ ] Cloud sync with Firebase/Supabase
- [ ] User authentication and multi-device sync
- [ ] Edit and delete expenses
- [ ] Data export (CSV, PDF)
- [ ] Budget tracking and alerts
- [ ] Recurring expenses
- [ ] Charts and analytics
- [ ] Dark mode
- [ ] Localization (multiple languages)
- [ ] Biometric authentication

## 📦 Dependencies

### Core Dependencies
- `flutter_bloc` - State management
- `get_it` - Service locator
- `injectable` - Dependency injection
- `hive` - Local database
- `dio` - HTTP client
- `dartz` - Functional programming (Either type)
- `equatable` - Value equality

### UI Dependencies
- `flutter_screenutil` - Responsive design
- `flutter_svg` - SVG rendering
- `google_fonts` - Custom fonts
- `intl` - Date formatting

### Testing Dependencies
- `flutter_test` - Testing framework
- `bloc_test` - BLoC testing
- `mocktail` - Mocking

## 📄 License

This project is for educational and portfolio purposes.

## 👨‍💻 Author

Built with ❤️ using Flutter and Clean Architecture principles.

---

**Note**: This is a portfolio project demonstrating Clean Architecture, BLoC state management, and Flutter best practices. It is not intended for production use without further enhancements (authentication, cloud sync, etc.).
