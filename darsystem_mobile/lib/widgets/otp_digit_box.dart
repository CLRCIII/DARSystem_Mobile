import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpDigitBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool autofocus;
  final ValueChanged<String> onChanged;
  final VoidCallback onBackspace;
  final ValueChanged<String> onPaste;

  const OtpDigitBox({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onBackspace,
    required this.onPaste,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46,
      height: 46,
      child: KeyboardListener(
        focusNode: FocusNode(skipTraversal: true),
        onKeyEvent: (event) {},
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          autofocus: autofocus,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          style: const TextStyle(
            color: Color(0xFF113D6D),
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          decoration: BoxDecorationInputDecoration.decoration,
          onChanged: onChanged,
          onTapOutside: (_) => focusNode.unfocus(),
          contextMenuBuilder: (context, editableTextState) {
            return AdaptiveTextSelectionToolbar.buttonItems(
              anchors: editableTextState.contextMenuAnchors,
              buttonItems: [
                ContextMenuButtonItem(
                  onPressed: () async {
                    final data = await Clipboard.getData('text/plain');
                    final text = data?.text ?? '';
                    onPaste(text);
                    editableTextState.hideToolbar();
                  },
                  label: 'Paste',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class BoxDecorationInputDecoration {
  static final decoration = InputDecoration(
    filled: true,
    fillColor: const Color.fromRGBO(255, 255, 255, 0.90),
    counterText: '',
    contentPadding: EdgeInsets.zero,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: Color(0xFF113D6D), width: 1.2),
    ),
  );
}
