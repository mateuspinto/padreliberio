import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/scroll_spy.dart';
import '../core/section.dart';
import '../features/about/about_section.dart';
import '../features/camera/camera_section.dart';
import '../features/donation/donation_section.dart';
import '../features/footer/footer_section.dart';
import '../features/history/history_section.dart';
import '../features/schedule/schedule_section.dart';
import '../features/velario/velario_section.dart';
import '../features/visit/visit_section.dart';
import '../widgets/navbar.dart';
import '../widgets/section_scaffold.dart';

/// Continuous single-page scroll, unchanged from the current Vue site model.
class DesktopShell extends ConsumerStatefulWidget {
  const DesktopShell({super.key});

  @override
  ConsumerState<DesktopShell> createState() => _DesktopShellState();
}

class _DesktopShellState extends ConsumerState<DesktopShell> {
  final _scrollController = ScrollController();
  final Map<Section, GlobalKey> _sectionKeys = {
    for (final section in Section.values) section: GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    ref
        .read(selectedSectionProvider.notifier)
        .select(sectionAtScrollPosition(_sectionKeys));
  }

  Widget _bodyFor(Section section) => switch (section) {
    Section.camera => const CameraSection(),
    Section.schedule => const ScheduleSection(),
    Section.velario => const VelarioSection(),
    Section.about => const AboutSection(),
    Section.history => const HistorySection(),
    Section.visit => const VisitSection(),
    Section.donation => const DonationSection(),
  };

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: Navbar(sectionKeys: _sectionKeys),
    body: SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          for (final section in Section.values)
            KeyedSubtree(
              key: _sectionKeys[section],
              child: SectionScaffold(child: _bodyFor(section)),
            ),
          const SectionScaffold(child: FooterSection()),
        ],
      ),
    ),
  );
}
