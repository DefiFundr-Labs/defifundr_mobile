import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/data/models/workspace_item_model.dart';

final List<WorkspaceItem> workSpaceItems = [
  WorkspaceItem(
      image: AppAssets.files,
      subtitle: 'Create, manage, and track your contracts.',
      title: 'Contracts',
      route: '/contractsScreen'),
  WorkspaceItem(
      image: AppAssets.money,
      subtitle: 'Manage payments and log work submissions.',
      title: 'Pay cycle',
      route: '/contractsScreen'),
  WorkspaceItem(
      image: AppAssets.invoice,
      subtitle: 'Create and send invoices with ease.',
      title: 'Invoice',
      route: '/contractsScreen'),
  WorkspaceItem(
      image: AppAssets.expenses,
      subtitle: 'Log and manage project expenses.',
      title: 'Expenses',
      route: '/contractsScreen'),
  WorkspaceItem(
      image: AppAssets.timeSheets,
      subtitle: 'Track hours and log work time.',
      title: 'Timesheets',
      route: '/contractsScreen'),
  WorkspaceItem(
      image: AppAssets.timeOff,
      subtitle: 'Request, schedule, and manage time off.',
      title: 'Time off',
      route: '/contractsScreen'),
];
