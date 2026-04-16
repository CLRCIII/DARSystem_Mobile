import 'package:flutter/material.dart';
import '../widgets/logo_container.dart';
import 'home_page.dart';
import 'dashboard_page.dart';
import 'profile_page.dart';
import 'report_details_page.dart';
import 'create_report_page.dart';

class MyReportsPage extends StatelessWidget {
  const MyReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCDCDC),
      body: SafeArea(
        child: Column(
          children: [
            const _MyReportsTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
children: const [
  _MyReportsHeaderCard(),
  SizedBox(height: 18),
  _CreateReportActionCard(),
  SizedBox(height: 18),
  _ReportsSummarySection(),
  SizedBox(height: 18),
  _ReportsListSection(),
],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyReportsTopBar extends StatelessWidget {
  const _MyReportsTopBar();

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
            label: 'Profile',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          const SizedBox(width: 8),
          const _NavButton(label: 'Reports', isActive: true),
        ],
      ),
    );
  }
}

class _MyReportsHeaderCard extends StatelessWidget {
  const _MyReportsHeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: Color(0xFF0C4C7F),
            child: Icon(
              Icons.description_outlined,
              color: Colors.white,
              size: 34,
            ),
          ),
          SizedBox(height: 14),
          Text(
            'My Reports',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'View your submitted accomplishment reports and their current status.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF6B7280), fontSize: 13.5),
          ),
        ],
      ),
    );
  }
}

class _CreateReportActionCard extends StatelessWidget {
  const _CreateReportActionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF6FF),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFD5E6FB)),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFF0C4C7F),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.note_add_outlined, color: Colors.white),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create a new report',
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'The mobile version now includes the create report feature from the DAR web system.',
                  style: TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 12.8,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateReportPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A3F72),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}

class _ReportsSummarySection extends StatelessWidget {
  const _ReportsSummarySection();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _MiniSummaryCard(
            title: 'Submitted',
            value: '24',
            background: Color(0xFFEDE9FE),
            foreground: Color(0xFF6D28D9),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _MiniSummaryCard(
            title: 'Approved',
            value: '18',
            background: Color(0xFFDCFCE7),
            foreground: Color(0xFF166534),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _MiniSummaryCard(
            title: 'Pending',
            value: '4',
            background: Color(0xFFFEF3C7),
            foreground: Color(0xFF92400E),
          ),
        ),
      ],
    );
  }
}

class _ReportsListSection extends StatefulWidget {
  const _ReportsListSection();

  @override
  State<_ReportsListSection> createState() => _ReportsListSectionState();
}

class _ReportsListSectionState extends State<_ReportsListSection> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedStatus = 'All';
  DateTime? _fromDate;
  DateTime? _toDate;

  final List<_ReportItem> _reports = [
    const _ReportItem(
      title: 'Daily Accomplishment Report',
      fileName: 'DAR_March_25.pdf',
      submittedDate: 'March 25, 2026',
      status: 'Approved',
    ),
    const _ReportItem(
      title: 'Weekly Accomplishment Report',
      fileName: 'Weekly_Report_Maria.pdf',
      submittedDate: 'March 26, 2026',
      status: 'Pending',
    ),
    const _ReportItem(
      title: 'Monthly Summary Report',
      fileName: 'Monthly_Summary_March.pdf',
      submittedDate: 'March 30, 2026',
      status: 'For Revision',
    ),
    const _ReportItem(
      title: 'Daily Accomplishment Report',
      fileName: 'DAR_April_01.pdf',
      submittedDate: 'April 1, 2026',
      status: 'Submitted',
    ),
  ];

  List<_ReportItem> get _filteredReports {
    final query = _searchController.text.trim().toLowerCase();

    return _reports.where((report) {
      final reportDate = _parseSubmittedDate(report.submittedDate);

      final matchesSearch =
          query.isEmpty ||
          report.title.toLowerCase().contains(query) ||
          report.fileName.toLowerCase().contains(query) ||
          report.status.toLowerCase().contains(query) ||
          report.submittedDate.toLowerCase().contains(query);

      final matchesStatus =
          _selectedStatus == 'All' || report.status == _selectedStatus;

      final matchesFrom =
          _fromDate == null ||
          !reportDate.isBefore(DateTime(_fromDate!.year, _fromDate!.month, _fromDate!.day));

      final matchesTo =
          _toDate == null ||
          !reportDate.isAfter(DateTime(_toDate!.year, _toDate!.month, _toDate!.day, 23, 59, 59));

      return matchesSearch && matchesStatus && matchesFrom && matchesTo;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isFrom}) async {
    final initialDate = isFrom
        ? (_fromDate ?? DateTime.now())
        : (_toDate ?? DateTime.now());

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked == null) return;

    setState(() {
      if (isFrom) {
        _fromDate = picked;
        if (_toDate != null && _toDate!.isBefore(picked)) {
          _toDate = picked;
        }
      } else {
        _toDate = picked;
      }
    });
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      _selectedStatus = 'All';
      _fromDate = null;
      _toDate = null;
    });
  }

  void _renameReport(_ReportItem report) {
    final controller = TextEditingController(text: report.fileName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit File Name'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter new file name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newName = controller.text.trim();
                if (newName.isEmpty) return;

                setState(() {
                  final index = _reports.indexOf(report);
                  _reports[index] = report.copyWith(fileName: newName);
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('File name updated.')),
                );
              },
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  void _deleteReport(_ReportItem report) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Report'),
          content: Text(
            'Are you sure you want to delete "${report.fileName}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _reports.remove(report);
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Report deleted.')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB91C1C),
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  DateTime _parseSubmittedDate(String value) {
    const months = {
      'january': 1,
      'february': 2,
      'march': 3,
      'april': 4,
      'may': 5,
      'june': 6,
      'july': 7,
      'august': 8,
      'september': 9,
      'october': 10,
      'november': 11,
      'december': 12,
    };

    final cleaned = value.replaceAll(',', '');
    final parts = cleaned.split(' ');
    final month = months[parts[0].toLowerCase()] ?? 1;
    final day = int.tryParse(parts[1]) ?? 1;
    final year = int.tryParse(parts[2]) ?? 2026;

    return DateTime(year, month, day);
  }

  String _formatDate(DateTime? value) {
    if (value == null) return 'Select date';

    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    return '${months[value.month - 1]} ${value.day}, ${value.year}';
  }

  @override
  Widget build(BuildContext context) {
    final filteredReports = _filteredReports;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Submitted Reports',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),

          TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Search report file names',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
            ),
          ),

          const SizedBox(height: 14),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _filterChip('All'),
              _filterChip('Approved'),
              _filterChip('Pending'),
              _filterChip('For Revision'),
              _filterChip('Submitted'),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: _dateField(
                  label: 'From',
                  value: _formatDate(_fromDate),
                  onTap: () => _pickDate(isFrom: true),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _dateField(
                  label: 'To',
                  value: _formatDate(_toDate),
                  onTap: () => _pickDate(isFrom: false),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: _clearFilters,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset Filters'),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            '${filteredReports.length} report(s) found',
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          if (filteredReports.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.search_off_outlined,
                    size: 34,
                    color: Color(0xFF9CA3AF),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'No reports found',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Try changing your search or date filters.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            )
          else
            ...filteredReports.map(
              (report) => _MyReportCard(
                title: report.title,
                fileName: report.fileName,
                submittedDate: report.submittedDate,
                status: report.status,
                onRename: () => _renameReport(report),
                onDelete: () => _deleteReport(report),
              ),
            ),
        ],
      ),
    );
  }

  Widget _filterChip(String label) {
    final isSelected = _selectedStatus == label;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        setState(() {
          _selectedStatus = label;
        });
      },
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : const Color(0xFF374151),
        fontWeight: FontWeight.w600,
        fontSize: 12.5,
      ),
      selectedColor: const Color(0xFF0A3F72),
      backgroundColor: Colors.white,
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
        side: BorderSide(
          color: isSelected
              ? const Color(0xFF0A3F72)
              : const Color(0xFFD1D5DB),
        ),
      ),
    );
  }

  Widget _dateField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
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
                    value,
                    style: TextStyle(
                      color: value == 'Select date'
                          ? const Color(0xFF9CA3AF)
                          : const Color(0xFF111827),
                      fontSize: 13,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Submitted Reports',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16),
          _MyReportCard(
            title: 'Daily Accomplishment Report',
            fileName: 'DAR_March_25.pdf',
            submittedDate: 'March 25, 2026',
            status: 'Approved',
          ),
          _MyReportCard(
            title: 'Weekly Accomplishment Report',
            fileName: 'Weekly_Report_Maria.pdf',
            submittedDate: 'March 26, 2026',
            status: 'Pending',
          ),
          _MyReportCard(
            title: 'Monthly Summary Report',
            fileName: 'Monthly_Summary_March.pdf',
            submittedDate: 'March 30, 2026',
            status: 'For Revision',
          ),
          _MyReportCard(
            title: 'Daily Accomplishment Report',
            fileName: 'DAR_April_01.pdf',
            submittedDate: 'April 1, 2026',
            status: 'Submitted',
          ),
        ],
      ),
    );
  }

class _MyReportCard extends StatelessWidget {
  final String title;
  final String fileName;
  final String submittedDate;
  final String status;
  final VoidCallback? onRename;
  final VoidCallback? onDelete;

  const _MyReportCard({
    required this.title,
    required this.fileName,
    required this.submittedDate,
    required this.status,
    this.onRename,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final statusStyle = _getStatusStyle(status);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          _infoRow('File Name', fileName),
          const SizedBox(height: 6),
          _infoRow('Submitted', submittedDate),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusStyle.background,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusStyle.foreground,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _actionButton(
                'View',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReportDetailsPage(),
                    ),
                  );
                },
              ),
              _actionButton('Download', onTap: () {}),
              _actionButton('Rename', onTap: onRename),
              _actionButton('Delete', onTap: onDelete, isDanger: true),
              _actionButton('Edit', onTap: status == 'Approved' ? null : () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Color(0xFF374151), fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _actionButton(
    String label, {
    VoidCallback? onTap,
    bool isDanger = false,
  }) {
    final disabled = onTap == null;

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: disabled
            ? const Color(0xFFE5E7EB)
            : isDanger
                ? const Color(0xFFB91C1C)
                : const Color(0xFF0A3F72),
        foregroundColor: disabled ? const Color(0xFF9CA3AF) : Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label),
    );
  }

  _StatusStyle _getStatusStyle(String status) {
    switch (status) {
      case 'Approved':
        return const _StatusStyle(
          background: Color(0xFFDCFCE7),
          foreground: Color(0xFF166534),
        );
      case 'Pending':
        return const _StatusStyle(
          background: Color(0xFFFEF3C7),
          foreground: Color(0xFF92400E),
        );
      case 'For Revision':
        return const _StatusStyle(
          background: Color(0xFFFEE2E2),
          foreground: Color(0xFF991B1B),
        );
      default:
        return const _StatusStyle(
          background: Color(0xFFEDE9FE),
          foreground: Color(0xFF6D28D9),
        );
    }
  }
}

class _MiniSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color background;
  final Color foreground;

  const _MiniSummaryCard({
    required this.title,
    required this.value,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: foreground,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF4B5563),
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const _NavButton({required this.label, this.isActive = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isActive ? null : onTap,
      borderRadius: BorderRadius.circular(999),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white70,
            fontSize: 13,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _ReportItem {
  final String title;
  final String fileName;
  final String submittedDate;
  final String status;

  const _ReportItem({
    required this.title,
    required this.fileName,
    required this.submittedDate,
    required this.status,
  });

  _ReportItem copyWith({
    String? title,
    String? fileName,
    String? submittedDate,
    String? status,
  }) {
    return _ReportItem(
      title: title ?? this.title,
      fileName: fileName ?? this.fileName,
      submittedDate: submittedDate ?? this.submittedDate,
      status: status ?? this.status,
    );
  }
}

class _StatusStyle {
  final Color background;
  final Color foreground;

  const _StatusStyle({required this.background, required this.foreground});
}
