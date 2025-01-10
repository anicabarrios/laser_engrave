import 'package:flutter/material.dart';
import '../../utils/colors.dart';


class ContactForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController messageController;
  final List<String> services;
  final List<String> budgetRanges;
  final String? selectedService;
  final String? selectedBudget;
  final DateTime? preferredDate;
  final bool isSubmitting;
  final Future<void> Function() onSubmit;
  final void Function() onReset;
  final void Function(String?) onServiceChanged;
  final void Function(String?) onBudgetChanged;
  final void Function(DateTime?) onDateSelected;

  const ContactForm({
    Key? key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.messageController,
    required this.services,
    required this.budgetRanges,
    required this.selectedService,
    required this.selectedBudget,
    required this.preferredDate,
    required this.isSubmitting,
    required this.onSubmit,
    required this.onReset,
    required this.onServiceChanged,
    required this.onBudgetChanged,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.pearl,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Tell Us About Your Project', 'We\'re excited to hear about your vision'),
            const SizedBox(height: 32),
            _buildInputField(
              controller: widget.nameController,
              label: 'Full Name',
              prefixIcon: Icons.person_outline,
              validator: (value) => value?.isEmpty ?? true ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 24),
            _buildInputField(
              controller: widget.emailController,
              label: 'Email Address',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Please enter your email';
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            _buildInputField(
              controller: widget.phoneController,
              label: 'Phone Number (Optional)',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            _buildDropdownField(
              value: widget.selectedService,
              items: widget.services,
              label: 'Service Type',
              prefixIcon: Icons.design_services_outlined,
              hint: 'Select a service',
              onChanged: widget.onServiceChanged,
              validator: (value) => value == null ? 'Please select a service' : null,
            ),
            const SizedBox(height: 24),
            _buildDropdownField(
              value: widget.selectedBudget,
              items: widget.budgetRanges,
              label: 'Budget Range',
              prefixIcon: Icons.attach_money_outlined,
              hint: 'Select your budget range',
              onChanged: widget.onBudgetChanged,
            ),
            const SizedBox(height: 24),
            _buildDatePicker(context),
            const SizedBox(height: 24),
            _buildInputField(
              controller: widget.messageController,
              label: 'Project Details',
              prefixIcon: Icons.description_outlined,
              maxLines: 5,
              validator: (value) => value?.isEmpty ?? true ? 'Please tell us about your project' : null,
            ),
            const SizedBox(height: 32),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.darkTextColor, height: 1.2)
        ),
        const SizedBox(height: 8),
        Text(subtitle,
          style: TextStyle(fontSize: 16, color: AppColors.darkTextColor.withOpacity(0.7), height: 1.5)
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon, color: AppColors.sapphire),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.darkTextColor.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.darkTextColor.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.sapphire, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: maxLines > 1 ? 24 : 16,
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required List<String> items,
    required String label,
    required IconData prefixIcon,
    required String hint,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item, style: const TextStyle(color: AppColors.darkTextColor, fontSize: 15)),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.darkTextColor.withOpacity(0.7)),
        prefixIcon: Icon(prefixIcon, color: AppColors.sapphire.withOpacity(0.8)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.platinum),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.platinum),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.sapphire.withOpacity(0.5), width: 1.5),
        ),
        filled: true,
        fillColor: AppColors.pearl.withOpacity(0.9),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      icon: Icon(Icons.arrow_drop_down, color: AppColors.sapphire.withOpacity(0.7)),
      dropdownColor: AppColors.pearl.withOpacity(0.95),
      style: const TextStyle(color: AppColors.darkTextColor),
      hint: Text(hint),
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now().add(const Duration(days: 1)),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColors.sapphire,
                  onPrimary: AppColors.lightTextColor,
                  surface: AppColors.pearl,
                  onSurface: AppColors.darkTextColor,
                ),
              ),
              child: child!,
            );
          },
        );
        if (date != null) {
          widget.onDateSelected(date);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Preferred Start Date (Optional)',
          prefixIcon: Icon(Icons.calendar_today_outlined, color: AppColors.sapphire),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.darkTextColor.withOpacity(0.2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.darkTextColor.withOpacity(0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.sapphire, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        child: Text(
          widget.preferredDate != null
              ? '${widget.preferredDate!.day}/${widget.preferredDate!.month}/${widget.preferredDate!.year}'
              : 'Select a date',
          style: TextStyle(
            color: widget.preferredDate != null
                ? AppColors.darkTextColor
                : AppColors.darkTextColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.sapphire,
            AppColors.sapphire.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.sapphire.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: widget.isSubmitting ? null : widget.onSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.lightTextColor,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: widget.isSubmitting
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.lightTextColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.send, size: 20, color: AppColors.lightTextColor),
                  const SizedBox(width: 12),
                  Text(
                    'Send Message',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightTextColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
