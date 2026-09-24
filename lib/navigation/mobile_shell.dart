import 'package:flutter/material.dart';

import '../core/section.dart';
import '../features/donation/donation_section.dart';
import '../features/home/home_section.dart';
import '../features/more/more_section.dart';
import '../features/schedule/schedule_section.dart';
import '../l10n/generated/app_localizations.dart';
import '../widgets/cross_icon.dart';
import '../widgets/fixed_bottom_bar.dart';
import '../widgets/section_scaffold.dart';

enum _MobileTab { home, schedule, donation, more }

/// 4 fixed bottom-bar tabs (Mateus's IA): Início (camera + intro), Horários
/// (masses/lives), Doação, and Outros (menu list for everything else) — see
/// the redesign plan for the full rationale.
class MobileShell extends StatefulWidget {
  const MobileShell({super.key});

  @override
  State<MobileShell> createState() => _MobileShellState();
}

class _MobileShellState extends State<MobileShell> {
  var _tab = _MobileTab.home;

  String _title(_MobileTab tab, AppLocalizations l10n) => switch (tab) {
    _MobileTab.home => l10n.appTitle,
    _MobileTab.schedule => l10n.navSchedule,
    _MobileTab.donation => l10n.navDonation,
    _MobileTab.more => l10n.navMore,
  };

  Widget _bodyFor(_MobileTab tab) => switch (tab) {
    _MobileTab.home => const HomeSection(),
    _MobileTab.schedule => const ScheduleSection(),
    _MobileTab.donation => const DonationSection(),
    _MobileTab.more => const MoreSection(),
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(_title(_tab, l10n))),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _tab == _MobileTab.more
            ? const MoreSection(key: ValueKey(_MobileTab.more))
            : SingleChildScrollView(
                key: ValueKey(_tab),
                child: SectionScaffold(child: _bodyFor(_tab)),
              ),
      ),
      bottomNavigationBar: FixedBottomBar(
        selectedIndex: _MobileTab.values.indexOf(_tab),
        onSelect: (index) => setState(() => _tab = _MobileTab.values[index]),
        items: [
          BottomBarItem(
            iconBuilder: (color) => CrossIcon(color: color),
            label: l10n.navHome,
          ),
          BottomBarItem(
            iconBuilder: (color) => Icon(Section.schedule.icon, color: color),
            label: l10n.navSchedule,
          ),
          BottomBarItem(
            iconBuilder: (color) => Icon(Section.donation.icon, color: color),
            label: l10n.navDonation,
          ),
          BottomBarItem(
            iconBuilder: (color) => Icon(Icons.more_horiz, color: color),
            label: l10n.navMore,
          ),
        ],
      ),
    );
  }
}
