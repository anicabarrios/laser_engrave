import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:laser_engrave/widgets/footer.dart';
import '../../utils/colors.dart';
import '../../utils/screen_utils.dart';
import '../../config/responsive_breakpoints.dart';
import '../../widgets/custom_drawer.dart';
import '../../screens/home/floating_contact_button.dart';
import '../../widgets/hero.dart';
import 'contact_form.dart';
import 'contact_info.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});
  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  String? _selectedService;
  String? _selectedBudget;
  DateTime? _preferredDate;
  bool _isSubmitting = false;

  late AnimationController _animationController;
  final Map<String, bool> _visibleSections = {
    'hero': false,
    'form': false,
    'info': false,
    'footer': false,
  };

  final List<String> _services = [
    'Custom Product Engraving',
    'Industrial Marking',
    'Gift Personalization',
    'Corporate Solutions',
    'Bulk Orders',
    'Other Services',
  ];

  final List<String> _budgetRanges = [
    'Under \$500',
    '\$500 - \$1,000',
    '\$1,000 - \$5,000',
    '\$5,000+',
    'Not Sure',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _visibleSections['hero'] = true;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onSectionVisibilityChanged(String sectionKey, bool isVisible) {
    if (isVisible && !(_visibleSections[sectionKey] ?? false)) {
      setState(() {
        _visibleSections[sectionKey] = true;
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      HapticFeedback.mediumImpact();

      try {
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          setState(() => _isSubmitting = false);
          _showSuccessDialog();
          _resetForm();
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isSubmitting = false);
          _showErrorSnackbar('Failed to send message. Please try again.');
        }
      }
    }
  }

  void _resetForm() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _messageController.clear();
    setState(() {
      _selectedService = null;
      _selectedBudget = null;
      _preferredDate = null;
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.pearl,
                AppColors.pearl.withOpacity(0.95),
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.sapphire.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  size: 48,
                  color: AppColors.sapphire,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Message Sent Successfully!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTextColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Thank you for reaching out. We will get back to you within 24 hours.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.darkTextColor.withOpacity(0.7),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.sapphire,
                    foregroundColor: AppColors.lightTextColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Great!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColors.lightTextColor),
          ),
        ),
      ),
      backgroundColor: AppColors.lightColor,
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Hero Section
                _buildAnimatedSection(
                  'hero',
                  const HeroSection(
                    title: 'Let\'s Create Something Amazing',
                    subtitle: 'Share your vision, and we\'ll bring it to life with precision',
                  ),
                  initialDelay: 0.0,
                  useScale: true,
                ),

                // Contact Form and Info
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtils.getResponsivePadding(context),
                    vertical: isSmallScreen ? 40 : 80,
                  ),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: isSmallScreen
                        ? Column(
                            children: [
                              _buildAnimatedSection(
                                'form',
                                ContactForm(
                                  formKey: _formKey,
                                  nameController: _nameController,
                                  emailController: _emailController,
                                  phoneController: _phoneController,
                                  messageController: _messageController,
                                  services: _services,
                                  budgetRanges: _budgetRanges,
                                  selectedService: _selectedService,
                                  selectedBudget: _selectedBudget,
                                  preferredDate: _preferredDate,
                                  isSubmitting: _isSubmitting,
                                  onSubmit: _handleSubmit,
                                  onReset: _resetForm,
                                  onServiceChanged: (value) {
                                    setState(() => _selectedService = value);
                                  },
                                  onBudgetChanged: (value) {
                                    setState(() => _selectedBudget = value);
                                  },
                                  onDateSelected: (date) {
                                    setState(() => _preferredDate = date);
                                  },
                                ),
                                initialDelay: 0.2,
                                useScale: true,
                              ),
                              const SizedBox(height: 40),
                              _buildAnimatedSection(
                                'info',
                                const ContactInfo(),
                                initialDelay: 0.3,
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _buildAnimatedSection(
                                  'form',
                                  ContactForm(
                                    formKey: _formKey,
                                    nameController: _nameController,
                                    emailController: _emailController,
                                    phoneController: _phoneController,
                                    messageController: _messageController,
                                    services: _services,
                                    budgetRanges: _budgetRanges,
                                    selectedService: _selectedService,
                                    selectedBudget: _selectedBudget,
                                    preferredDate: _preferredDate,
                                    isSubmitting: _isSubmitting,
                                    onSubmit: _handleSubmit,
                                    onReset: _resetForm,
                                    onServiceChanged: (value) {
                                      setState(() => _selectedService = value);
                                    },
                                    onBudgetChanged: (value) {
                                      setState(() => _selectedBudget = value);
                                    },
                                    onDateSelected: (date) {
                                      setState(() => _preferredDate = date);
                                    },
                                  ),
                                  initialDelay: 0.2,
                                  useScale: true,
                                ),
                              ),
                              const SizedBox(width: 40),
                              Expanded(
                                child: _buildAnimatedSection(
                                  'info',
                                  const ContactInfo(),
                                  initialDelay: 0.3,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),

                // Footer
                _buildAnimatedSection(
                  'footer',
                  const Footer(),
                  initialDelay: 0.4,
                ),
              ],
            ),
          ),

          // Floating Contact Button
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
              ),
            ),
            child: const FloatingContactButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedSection(
    String key,
    Widget child, {
    double initialDelay = 0.0,
    bool useScale = false,
  }) {
    return VisibilityDetector(
      key: Key(key),
      onVisibilityChanged: (visibilityInfo) {
        _onSectionVisibilityChanged(key, visibilityInfo.visibleFraction > 0.3);
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOut,
        opacity: _visibleSections[key] ?? false ? 1.0 : 0.0,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOut,
          offset: _visibleSections[key] ?? false
              ? Offset.zero
              : const Offset(0, 0.1),
          child: useScale
              ? TweenAnimationBuilder<double>(
                  tween: Tween(
                    begin: 0.8,
                    end: _visibleSections[key] ?? false ? 1.0 : 0.8,
                  ),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: child,
                    );
                  },
                  child: child,
                )
              : child,
        ),
      ),
    );
  }
}