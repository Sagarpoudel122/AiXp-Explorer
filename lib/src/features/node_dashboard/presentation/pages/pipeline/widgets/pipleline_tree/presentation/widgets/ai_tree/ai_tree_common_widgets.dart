// part of ai;

// class AITreeItemButton extends StatelessWidget {
//   const AITreeItemButton({
//     super.key,
//     this.onTap,
//     required this.icon,
//   });

//   final IconData? icon;
//   final void Function()? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Clickable(
//       onTap: onTap,
//       style: ClickableStyle(
//         backgroundColor: Colors.black12,// Color(0xff2b2b2b),
//         backgroundColorHovered: Colors.black12,
//         borderColor: Colors.black12,
//         borderColorHovered:
//             HFColors.dark600, // HFColors.selectedHoverButtonBlue,
//       ),
//       height: 24,
//       width: 24,
//       borderRadius: 4,
//       shapeCorners: ShapeUtilsCorners.all,
//       childBuilder: (bool isHovered) {
//         return Icon(
//           icon,
//           color: isHovered ? HFColors.light100 : HFColors.light200,
//           // const Color(0xff828282),
//           size: 16,
//         );
//       },
//     );
//   }
// }

part of ai;

class AITreeItemButton extends StatelessWidget {
  const AITreeItemButton({
    super.key,
    this.onTap,
    required this.icon,
  });

  final IconData? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap,
      child: Row(
        children: [
          Icon(icon),
          Text("Clickable"),
        ],
      ),
    );
  }
}

