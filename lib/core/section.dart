import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/generated/app_localizations.dart';

enum Section { camera, schedule, velario, about, history, visit, donation }

extension SectionLabels on Section {
  String label(AppLocalizations l10n) => switch (this) {
    Section.camera => l10n.navCamera,
    Section.schedule => l10n.navSchedule,
    Section.velario => l10n.navVelario,
    Section.about => l10n.navAbout,
    Section.history => l10n.navHistory,
    Section.visit => l10n.navVisit,
    Section.donation => l10n.navDonation,
  };

  IconData get icon => switch (this) {
    Section.camera => Icons.videocam_outlined,
    Section.schedule => Icons.event_available_outlined,
    Section.velario => Icons.local_fire_department_outlined,
    Section.about => Icons.info_outline,
    Section.history => Icons.timeline_outlined,
    Section.visit => Icons.place_outlined,
    Section.donation => Icons.favorite_outline,
  };
}

class SelectedSectionNotifier extends Notifier<Section> {
  @override
  Section build() => Section.camera;

  void select(Section section) => state = section;
}

final selectedSectionProvider =
    NotifierProvider<SelectedSectionNotifier, Section>(
      SelectedSectionNotifier.new,
    );
