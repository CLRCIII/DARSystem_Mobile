import 'package:flutter/material.dart';
import '../widgets/logo_container.dart';
import 'dashboard_page.dart';
import 'home_page.dart';
import 'my_reports_page.dart';
import 'profile_page.dart';

class CreateReportPage extends StatefulWidget {
  const CreateReportPage({super.key});

  @override
  State<CreateReportPage> createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  final List<_ReportEntryData> _entries = [_ReportEntryData()];
  final TextEditingController _preparedByPositionController =
      TextEditingController(text: 'ICT Officer / Staff');
  final TextEditingController _approvedByNameController =
      TextEditingController();
  final TextEditingController _approvedByPositionController =
      TextEditingController();

  @override
  void dispose() {
    for (final entry in _entries) {
      entry.dispose();
    }
    _preparedByPositionController.dispose();
    _approvedByNameController.dispose();
    _approvedByPositionController.dispose();
    super.dispose();
  }

  void _addRow() {
    DateTime? nextDate;
    final lastEntry = _entries.isNotEmpty ? _entries.last : null;
    final baseDate = lastEntry?.endDate ?? lastEntry?.startDate;

    if (baseDate != null) {
      nextDate = baseDate.add(const Duration(days: 1));
    }

    setState(() {
      _entries.add(_ReportEntryData(startDate: nextDate));
    });
  }

  void _removeRow(int index) {
    if (_entries.length == 1) {
      return;
    }

    setState(() {
      final entry = _entries.removeAt(index);
      entry.dispose();
    });
  }

  Future<void> _pickDate({
    required int index,
    required bool isStart,
  }) async {
    final entry = _entries[index];
    final initialDate =
        (isStart ? entry.startDate : entry.endDate) ?? DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked == null) {
      return;
    }

    setState(() {
      if (isStart) {
        entry.startDate = picked;
        if (entry.endDate != null && entry.endDate!.isBefore(picked)) {
          entry.endDate = picked;
        }
      } else {
        entry.endDate = picked;
      }
    });
  }

  String _reportPeriodLabel() {
    final dates = <DateTime>[];

    for (final entry in _entries) {
      if (entry.startDate != null) {
        dates.add(_dateOnly(entry.startDate!));
      }
      if (entry.endDate != null) {
        dates.add(_dateOnly(entry.endDate!));
      }
    }

    if (dates.isEmpty) {
      return 'Daily Accomplishment Report';
    }

    dates.sort();
    final start = dates.first;
    final end = dates.last;

    if (_sameDay(start, end)) {
      return 'Daily Accomplishment Report ${_formatLongDate(start)}';
    }

    return 'Daily Accomplishment Report ${_formatLongDate(start)} - ${_formatLongDate(end)}';
  }

  void _saveDraft() {
    if (!_hasAtLeastOneFilledRow()) {
      _showMessage('Add at least one activity before saving.');
      return;
    }

    _showMessage('Report draft saved locally in the mobile prototype.');
  }

  void _submitReport() {
    if (!_isFormValid()) {
      _showMessage('Complete the required fields first.');
      return;
    }

    _showMessage('Report submitted successfully.');
  }

  bool _hasAtLeastOneFilledRow() {
    return _entries.any(
      (entry) =>
          entry.startDate != null ||
          entry.endDate != null ||
          entry.activityController.text.trim().isNotEmpty ||
          entry.detailsController.text.trim().isNotEmpty ||
          entry.remarksController.text.trim().isNotEmpty,
    );
  }

  bool _isFormValid() {
    if (!_hasAtLeastOneFilledRow()) {
      return false;
    }

    for (final entry in _entries) {
      final hasContent =
          entry.startDate != null ||
          entry.endDate != null ||
          entry.activityController.text.trim().isNotEmpty ||
          entry.detailsController.text.trim().isNotEmpty ||
          entry.remarksController.text.trim().isNotEmpty;

      if (!hasContent) {
        continue;
      }

      if (entry.startDate == null || entry.activityController.text.trim().isEmpty) {
        return false;
      }
    }

    return true;
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCDCDC),
      body: SafeArea(
        child: Column(
          children: [
            const _CreateReportTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWorkspaceHeader(context),
                    const SizedBox(height: 18),
                    _buildReportStage(),
                    const SizedBox(height: 16),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkspaceHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Create Report',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'This mobile screen now includes the create report feature from the web Daily Accomplishment Report, including dynamic rows, report period preview, signatures, and save or submit actions.',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 13.5,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyReportsPage(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF476179),
                  side: const BorderSide(color: Color(0xFFD6DDE7)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                icon: const Icon(Icons.arrow_back, size: 18),
                label: const Text('Back'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportStage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF2F5F8), Color(0xFFECF1F5)],
        ),
        border: Border.all(color: const Color(0xFFD8E0E8)),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Center(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 820),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFF2A7BD6), width: 2),
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14212E3A),
                blurRadius: 24,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        LogoContainer(
                          imagePath: 'assets/images/dict_logo.png',
                          size: 46,
                        ),
                        SizedBox(width: 10),
                        LogoContainer(
                          imagePath: 'assets/images/bagong_pilipinas.png',
                          size: 46,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      child: Text(
                        _reportPeriodLabel(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              ...List.generate(_entries.length, (index) {
                final entry = _entries[index];
                return _buildEntryCard(entry, index);
              }),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _addRow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A0A0A),
                      foregroundColor: Colors.white,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(14),
                      elevation: 0,
                    ),
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Add another row when you need more activities for the same report.',
                      style: TextStyle(
                        color: Color(0xFF708194),
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 650;
                  return Flex(
                    direction: isNarrow ? Axis.vertical : Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildSignatureBlock(
                          title: 'Prepared by:',
                          name: 'LOUIS RAMAT',
                          positionController: _preparedByPositionController,
                          icon: Icons.draw_outlined,
                          showSignaturePreview: true,
                        ),
                      ),
                      SizedBox(width: isNarrow ? 0 : 28, height: isNarrow ? 20 : 0),
                      Expanded(
                        child: _buildApprovalBlock(),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEntryCard(_ReportEntryData entry, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Activity Row ${index + 1}',
                style: const TextStyle(
                  color: Color(0xFF1F3E62),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              if (_entries.length > 1)
                IconButton(
                  onPressed: () => _removeRow(index),
                  icon: const Icon(Icons.delete_outline),
                  color: const Color(0xFFB91C1C),
                  tooltip: 'Remove row',
                ),
            ],
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 620;

              return Flex(
                direction: isNarrow ? Axis.vertical : Axis.horizontal,
                children: [
                  Expanded(
                    child: _DateFieldCard(
                      label: 'Start Date',
                      value: entry.startDate,
                      onTap: () => _pickDate(index: index, isStart: true),
                    ),
                  ),
                  SizedBox(width: isNarrow ? 0 : 12, height: isNarrow ? 12 : 0),
                  Expanded(
                    child: _DateFieldCard(
                      label: 'End Date',
                      value: entry.endDate,
                      onTap: () => _pickDate(index: index, isStart: false),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          _InputField(
            label: 'Activity / Task',
            controller: entry.activityController,
            hint: 'Enter the activity or task.',
            minLines: 2,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          _InputField(
            label: 'Details / Description',
            controller: entry.detailsController,
            hint: 'Describe what was accomplished.',
            minLines: 4,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          _InputField(
            label: 'Remarks',
            controller: entry.remarksController,
            hint: 'Add remarks or notes if needed.',
            minLines: 3,
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
    );
  }

  Widget _buildSignatureBlock({
    required String title,
    required String name,
    required TextEditingController positionController,
    required IconData icon,
    required bool showSignaturePreview,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF111827),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 18),
        if (showSignaturePreview)
          Container(
            width: 120,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2FE),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: const Color(0xFF0C4C7F), size: 18),
                const SizedBox(width: 8),
                const Text(
                  'Signature',
                  style: TextStyle(
                    color: Color(0xFF0C4C7F),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        if (showSignaturePreview) const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.only(bottom: 6),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFF111827))),
          ),
          child: Text(
            name,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 15,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: positionController,
          decoration: InputDecoration(
            hintText: 'Position',
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildApprovalBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Approved by:',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 18),
        TextField(
          controller: _approvedByNameController,
          decoration: _textFieldDecoration('Name'),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _approvedByPositionController,
          decoration: _textFieldDecoration('Position'),
        ),
      ],
    );
  }

  InputDecoration _textFieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: _saveDraft,
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF1F3E62),
            side: const BorderSide(color: Color(0xFFCAD5E2)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Save Draft'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: _submitReport,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2EA44F),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

class _CreateReportTopBar extends StatelessWidget {
  const _CreateReportTopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A3F72), Color(0xFF0C4F88)],
        ),
      ),
      child: Row(
        children: [
          const Row(
            children: [
              LogoContainer(imagePath: 'assets/images/dict_logo.png', size: 30),
              SizedBox(width: 8),
              LogoContainer(
                imagePath: 'assets/images/bagong_pilipinas.png',
                size: 30,
              ),
            ],
          ),
          const Spacer(),
          _NavButton(
            label: 'Home',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          const SizedBox(width: 8),
          _NavButton(
            label: 'Dashboard',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DashboardPage()),
              );
            },
          ),
          const SizedBox(width: 8),
          _NavButton(
            label: 'Reports',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyReportsPage()),
              );
            },
          ),
          const SizedBox(width: 8),
          _NavButton(
            label: 'Profile',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DateFieldCard extends StatelessWidget {
  final String label;
  final DateTime? value;
  final VoidCallback onTap;

  const _DateFieldCard({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF4F5B66),
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFD1D5DB)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value == null ? 'Select date' : _formatShortDate(value!),
                    style: TextStyle(
                      color: value == null
                          ? const Color(0xFF9CA3AF)
                          : const Color(0xFF111827),
                      fontSize: 13.5,
                    ),
                  ),
                ),
                const Icon(Icons.calendar_today_outlined, size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final int minLines;
  final ValueChanged<String>? onChanged;

  const _InputField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.minLines,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF4F5B66),
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          minLines: minLines,
          maxLines: null,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
          ),
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _NavButton({required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _ReportEntryData {
  DateTime? startDate;
  DateTime? endDate;
  final TextEditingController activityController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  _ReportEntryData({this.startDate, this.endDate});

  void dispose() {
    activityController.dispose();
    detailsController.dispose();
    remarksController.dispose();
  }
}

DateTime _dateOnly(DateTime value) => DateTime(value.year, value.month, value.day);

bool _sameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

String _formatShortDate(DateTime value) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  return '${months[value.month - 1]} ${value.day}, ${value.year}';
}

String _formatLongDate(DateTime value) {
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  return '${months[value.month - 1]} ${value.day}, ${value.year}';
}