# Laser Engraving 

A responsive Flutter web application for a laser engraving company, optimized for all screen sizes including desktop, tablet, and mobile devices.

![Laser Engraving](https://via.placeholder.com/800x400)

## Overview

This project is a comprehensive, modern website for a laser engraving business that showcases their services, portfolio, and contact information. The website features a responsive design that adapts seamlessly to different screen sizes and devices.

## Features

- **Responsive Design**: Optimized for desktop, tablet, and mobile viewing experiences
- **Animated UI**: Smooth transitions and animations enhance user experience
- **Navigation**: Intuitive navigation with drawer menu for mobile devices
- **Sections**:
  - Home Page with hero section, features, project showcase, testimonials, and CTA
  - Gallery with filterable projects
  - About Us with company vision, team members, process, and technology
  - Contact Page with form submission and company information
- **Interactive Elements**:
  - Floating contact button
  - Hoverable cards
  - Category filters
  - Form validation

## Technology Stack

- **Flutter**: Cross-platform UI toolkit
- **Dart**: Programming language
- **Material Design**: UI components following Material design guidelines
- **Custom Animations**: Created with Flutter's animation controllers

## Project Structure

```
lib/
├── config/
│   ├── app_config.dart
│   ├── responsive_breakpoints.dart
│   ├── ...
├── models/
│   ├── carousel_item.dart
│   ├── feature.dart
│   ├── gallery_item.dart
│   ├── service.dart
│   ├── team_member.dart
│   ├── testimonial_model.dart
│   ├── ...
├── routes/
│   ├── routes.dart
├── screens/
│   ├── about/
│   │   ├── about_screen.dart
│   │   ├── vision_section.dart
│   │   ├── team_section.dart
│   │   ├── process_section.dart
│   │   ├── technology_section.dart
│   ├── contact/
│   │   ├── contact_screen.dart
│   │   ├── contact_form.dart
│   │   ├── contact_info.dart
│   ├── gallery/
│   │   ├── gallery_screen.dart
│   │   ├── gallery_section.dart
│   │   ├── gallery_grid.dart
│   │   ├── gallery_item.dart
│   │   ├── category_filter.dart
│   │   ├── project_details_dialog.dart
│   │   ├── gallery_data_provider.dart
│   ├── home/
│   │   ├── home_screen.dart
│   │   ├── hero_section.dart
│   │   ├── features_section.dart
│   │   ├── project_showcase.dart
│   │   ├── testimonials_section.dart
│   │   ├── cta.dart
│   │   ├── floating_contact_button.dart
├── utils/
│   ├── colors.dart
│   ├── screen_utils.dart
│   ├── ...
├── widgets/
│   ├── custom_drawer.dart
│   ├── footer.dart
│   ├── grid_pattern_painter.dart
│   ├── hero.dart
│   ├── ...
├── main.dart
```

## Responsive Design Features

The application implements responsive design through:

1. **ResponsiveBreakpoints**: A utility class that defines breakpoints for mobile, tablet, and desktop screens
2. **ScreenUtils**: Helper methods for responsive padding and font sizes
3. **Conditional Layouts**: Different layouts are rendered based on screen size
4. **Flexible Sizing**: Using relative sizing (Expanded, FractionallySizedBox, etc.) instead of fixed dimensions
5. **MediaQuery**: Accessing device screen information for responsive decisions
6. **Adaptive Spacing**: Adjusting padding, margins, and gaps based on screen size

## Key Components

### Screens

- **HomeScreen**: Landing page with various sections
- **GalleryScreen**: Portfolio of work with filtering capabilities
- **AboutScreen**: Company information, team, and processes
- **ContactScreen**: Contact form and company information

### Widgets

- **HeroSection**: Reusable hero component with animations
- **GridPatternPainter**: Custom painter for grid pattern backgrounds
- **FloatingContactButton**: Quick access contact options
- **CustomDrawer**: Navigation drawer for mobile screens
- **Footer**: Site-wide footer with navigation and contact information

## Getting Started

### Prerequisites

- Flutter SDK (version 3.0.0 or later)
- Dart SDK (version 2.17.0 or later)
- Any IDE with Flutter support (VS Code, Android Studio, etc.)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/laser_engrave.git
   ```

2. Navigate to the project directory:
   ```bash
   cd laser_engrave
   ```

3. Get dependencies:
   ```bash
   flutter pub get
   ```

4. Run the application:
   ```bash
   flutter run -d chrome
   ```

## Deployment

For web deployment:

1. Build the web application:
   ```bash
   flutter build web
   ```

2. Deploy the content of the `build/web` directory to your web hosting service

## Future Enhancements

- Add internationalization support
- Implement dark mode
- Add search functionality
- Integrate with backend APIs for form submission
- Add animation for transitions between pages
- Implement state management solution for larger scale

## Credits

- Design inspiration: [Source]
- Icons: Material Icons
- Fonts: Montserrat

## License

This project is licensed under the MIT License - see the LICENSE file for details.