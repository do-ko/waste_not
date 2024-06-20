import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class SoundController extends GetxController {
  static SoundController get instance => Get.find();

  static const Map<String, String> assetPaths = {"hello": "jingle_short.mp3"};

  RxBool playSounds = true.obs;

  static Future<void> playSound(String assetKey) async {
    SoundController soundController = Get.find();

    if (soundController.playSounds.value && assetPaths.containsKey(assetKey)) {
      AudioPlayer player = AudioPlayer();

      await player.play(AssetSource(assetPaths[assetKey] ?? ''),
          mode: PlayerMode.lowLatency, position: Duration.zero);
    }
  }
}
