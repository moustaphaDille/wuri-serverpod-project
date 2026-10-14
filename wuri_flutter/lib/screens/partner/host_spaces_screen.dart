import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/host_providers.dart';
import 'package:wuri_flutter/widgets/space_card.dart';

/// La liste des espaces de l'hôte, avec un bouton pour en ajouter.
class HostSpacesScreen extends ConsumerWidget {
  const HostSpacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final spaces = ref.watch(mySpacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.hostSpacesTitle),
        actions: [
          IconButton(
            tooltip: l10n.hostRequestsTitle,
            icon: const Icon(Icons.inbox_outlined),
            onPressed: () => context.push('/host/requests'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/host/spaces/new'),
        icon: const Icon(Icons.add),
        label: Text(l10n.addSpace),
      ),
      body: spaces.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.errorLoading),
              TextButton(
                onPressed: () => ref.invalidate(mySpacesProvider),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
        data: (list) => list.isEmpty
            ? Center(child: Text(l10n.noHostSpaces))
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                itemCount: list.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final space = list[index];
                  return SpaceCard(
                    space: space,
                    onTap: () => context.push('/space/${space.id}'),
                  );
                },
              ),
      ),
    );
  }
}