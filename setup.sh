#!/bin/bash

echo "🚀 Starting Project Setup..."

# 1. Create Directory Structure
echo "📂 Creating folder structure..."
mkdir -p lib/core/constants
mkdir -p lib/data/models
mkdir -p lib/data/repositories
mkdir -p lib/logic/user_bloc
mkdir -p lib/logic/chat_bloc
mkdir -p lib/presentation/screens
mkdir -p lib/presentation/widgets

# 2. Create Placeholder Files (Data Layer)
echo "📄 Creating Data Layer files..."
touch lib/core/constants/app_constants.dart
touch lib/data/models/message_model.dart
touch lib/data/models/user_model.dart
touch lib/data/repositories/chat_repository.dart

# 3. Create Placeholder Files (Logic Layer)
echo "📄 Creating BLoC files..."
touch lib/logic/user_bloc/user_bloc.dart
touch lib/logic/user_bloc/user_event.dart
touch lib/logic/user_bloc/user_state.dart
touch lib/logic/chat_bloc/chat_bloc.dart
touch lib/logic/chat_bloc/chat_event.dart
touch lib/logic/chat_bloc/chat_state.dart

# 4. Create Placeholder Files (Presentation Layer)
echo "📄 Creating UI files..."
touch lib/presentation/screens/home_screen.dart
touch lib/presentation/screens/chat_screen.dart
touch lib/presentation/screens/offers_screen.dart
touch lib/presentation/screens/settings_screen.dart
touch lib/presentation/widgets/custom_app_bar.dart
touch lib/presentation/widgets/message_bubble.dart

echo "✅ Project structure created successfully!"
echo "👉 You can now start copying the code into these files."