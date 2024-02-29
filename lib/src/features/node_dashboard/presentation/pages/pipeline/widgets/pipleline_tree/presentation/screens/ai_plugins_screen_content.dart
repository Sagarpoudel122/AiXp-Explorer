// part of ai;

// class AIPluginsScreenContent extends StatefulWidget {
//   const AIPluginsScreenContent({
//     super.key,
//   });

//   @override
//   State<AIPluginsScreenContent> createState() => _AIPluginsScreenContentState();
// }

// class _AIPluginsScreenContentState extends State<AIPluginsScreenContent> {
//   @override
//   void initState() {
//     super.initState();
//     () async {
//       _userProfile = await UserRepository().getUserProfile();
//       setState(() {
//         isLoading = false;
//       });
//     }.call();
//   }

//   AITreeValueSelectable<dynamic>? selectedItem;
//   late final UserProfile _userProfile;
//   bool isLoading = true;

//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? const Center(child: AnimatedLoading())
//         : Column(
//             children: <Widget>[
//               PageHeader(
//                 title: Text(AppStrings.aiPlugins.translate(context)),
//                 content: Container(),
//               ),
//               Expanded(
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Expanded(
//                       child: AITree(
//                         isSuper: _userProfile.isSuperOrPartner,
//                         onSelectionChanged:
//                             (AITreeValueSelectable<dynamic>? item) {
//                           debugPrint('Selection changed: $item');
//                           setState(() {
//                             selectedItem = item;
//                           });
//                         },
//                       ),
//                     ),
//                     Expanded(
//                       flex: 3,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: NewColors.containerBgColor,
//                             // border: Border.all(color: HFColors.dark700),
//                             borderRadius: const BorderRadius.all(
//                               Radius.circular(4),
//                             ),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8),
//                             child: selectedItem == null
//                                 ? Center(
//                                     child: EmptyStateWidget(
//                                       iconData: CarbonIcons.iot_platform,
//                                       title: 'Select a plugin to start',
//                                       titleColor: NewColors.textPrimaryColor,
//                                       iconSize: 26,
//                                     ),
//                                   )
//                                 : AITreeItemViewer(
//                                     item: selectedItem!,
//                                     onPluginInstanceSaveSuccessful:
//                                         selectedItem is AITreePluginNewInstance
//                                             ? (selectedItem!
//                                                     as AITreePluginNewInstance)
//                                                 .onSaveSuccess
//                                             : null,
//                                   ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//   }
// }
