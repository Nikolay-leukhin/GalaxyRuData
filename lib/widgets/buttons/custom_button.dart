import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/audio_repository.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:just_audio/just_audio.dart';

class CustomButton extends StatefulWidget {
  final Widget content;

  final VoidCallback onTap;
  final EdgeInsets padding;

  final double width;
  final double height;

  final bool isActive;

  final double radius;

  final Color color;
  final Gradient? gradient;
  final Color borderColor;

  final AudioPlayer audioPlayer;

  const CustomButton(
      {super.key,
      required this.content,
      required this.onTap,
      required this.width,
      required this.audioPlayer,
      this.borderColor = Colors.white,
      this.isActive = true,
      this.height = 60,
      this.padding = EdgeInsets.zero,
      this.radius = 16,
      this.gradient,
      this.color = AppColors.primary});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final musicRepository = RepositoryProvider.of<AudioRepository>(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        enableFeedback: false,
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          musicRepository.play(widget.audioPlayer);

          widget.onTap();
        },
        child: Ink(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
              gradient: widget.gradient,
              color: widget.isActive ? widget.color : AppColors.blueGrey,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  width: 1.6,
                  color:
                      widget.isActive ? widget.borderColor : AppColors.grey)),
          child: Padding(
            padding: widget.padding,
            child: Center(child: widget.content),
          ),
        ),
      ),
    );
  }
}
