import '../../l10n/generated/app_localizations.dart';

enum HistoryMilestoneId { first, second, third, fourth, fifth }

extension HistoryMilestoneText on HistoryMilestoneId {
  String year(AppLocalizations l10n) => switch (this) {
    HistoryMilestoneId.first => l10n.historyMilestone1Year,
    HistoryMilestoneId.second => l10n.historyMilestone2Year,
    HistoryMilestoneId.third => l10n.historyMilestone3Year,
    HistoryMilestoneId.fourth => l10n.historyMilestone4Year,
    HistoryMilestoneId.fifth => l10n.historyMilestone5Year,
  };

  String text(AppLocalizations l10n) => switch (this) {
    HistoryMilestoneId.first => l10n.historyMilestone1Text,
    HistoryMilestoneId.second => l10n.historyMilestone2Text,
    HistoryMilestoneId.third => l10n.historyMilestone3Text,
    HistoryMilestoneId.fourth => l10n.historyMilestone4Text,
    HistoryMilestoneId.fifth => l10n.historyMilestone5Text,
  };
}
