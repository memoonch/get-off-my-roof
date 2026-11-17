package com.getoffmyroof.audio
{
   import com.getoffmyroof.assets.Assets;
   import com.whatthefawk.audio.AudioManager;
   import com.whatthefawk.audio.AudioParams;
   import com.whatthefawk.audio.AudioTypes;
   import flash.media.Sound;
   
   public class AudioFiles
   {
      
      public function AudioFiles()
      {
         super();
      }
      
      public function register(param1:AudioManager) : void
      {
         param1.register(new AudioParams({
            "audioID":"MenuMusic",
            "sound":new music_menu() as Sound,
            "type":AudioTypes.MUSIC
         }));
         param1.register(new AudioParams({
            "audioID":"BattleMusic",
            "sound":new music_level_basic() as Sound,
            "type":AudioTypes.MUSIC
         }));
         param1.register(new AudioParams({
            "audioID":"BossMusic",
            "sound":new music_level_boss() as Sound,
            "type":AudioTypes.MUSIC
         }));
         param1.register(new AudioParams({
            "audioID":"WinLevelMusic",
            "sound":new music_win() as Sound,
            "type":AudioTypes.MUSIC
         }));
         param1.register(new AudioParams({
            "audioID":"LoseLevelMusic",
            "sound":new music_lose() as Sound,
            "type":AudioTypes.MUSIC
         }));
         param1.register(new AudioParams({
            "audioID":"ButtonClick",
            "sound":new ButtonClickSound4() as Sound,
            "type":AudioTypes.INTERFACE
         }));
         param1.register(new AudioParams({
            "audioID":"ButtonRollover",
            "sound":new ButtonSelectSound2() as Sound,
            "type":AudioTypes.INTERFACE
         }));
         param1.register(new AudioParams({
            "audioID":"PointDing",
            "sound":new Assets.POINT_DING_2_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"AchievementDing",
            "sound":new Assets.ACHIEVEMENT_DING_2_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"KillBoss",
            "sound":new Assets.KILLBOSS_4_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PlayerHit3",
            "groupIDs":["PlayerHit"],
            "sound":new Assets.PLAYER_HIT_3_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PlayerThrow1",
            "groupIDs":["PlayerThrow"],
            "sound":new Assets.OLD_MAN_THROW_1_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PlayerThrow2",
            "groupIDs":["PlayerThrow"],
            "sound":new Assets.OLD_MAN_THROW_2_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PlayerThrow3",
            "groupIDs":["PlayerThrow"],
            "sound":new Assets.OLD_MAN_THROW_3_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PlayerSwing1",
            "groupIDs":["PlayerSwing"],
            "sound":new Assets.OLD_MAN_SWING_1_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PlayerSwing2",
            "groupIDs":["PlayerSwing"],
            "sound":new Assets.OLD_MAN_SWING_2_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PlayerSwing3",
            "groupIDs":["PlayerSwing"],
            "sound":new Assets.OLD_MAN_SWING_3_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PlayerSwing4",
            "groupIDs":["PlayerSwing"],
            "sound":new Assets.OLD_MAN_SWING_4_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PlayerJump",
            "sound":new OldManJumpSound6() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PlayerUseWetnap",
            "sound":new Assets.PLAYER_USE_WETNAP_3_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonCoo1",
            "groupIDs":["PigeonCoo"],
            "sound":new Assets.PIGEON_COO_1_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonCoo2",
            "groupIDs":["PigeonCoo"],
            "sound":new Assets.PIGEON_COO_2_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonCoo3",
            "groupIDs":["PigeonCoo"],
            "sound":new Assets.PIGEON_COO_3_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonCoo4",
            "groupIDs":["PigeonCoo"],
            "sound":new Assets.PIGEON_COO_4_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonCoo5",
            "groupIDs":["PigeonCoo"],
            "sound":new Assets.PIGEON_COO_5_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonCoo6",
            "groupIDs":["PigeonCoo"],
            "sound":new Assets.PIGEON_COO_6_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonCoo7",
            "groupIDs":["PigeonCoo"],
            "sound":new Assets.PIGEON_COO_7_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonCaw1",
            "groupIDs":["PigeonCaw"],
            "sound":new Assets.PIGEON_CAW_1_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonCaw2",
            "groupIDs":["PigeonCaw"],
            "sound":new Assets.PIGEON_CAW_2_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonCaw3",
            "groupIDs":["PigeonCaw"],
            "sound":new Assets.PIGEON_CAW_3_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonCaw4",
            "groupIDs":["PigeonCaw"],
            "sound":new Assets.PIGEON_CAW_4_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonCaw5",
            "groupIDs":["PigeonCaw"],
            "sound":new Assets.PIGEON_CAW_5_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonHit1",
            "groupIDs":["PigeonHit"],
            "sound":new Assets.PIGEON_HIT_1_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonHit2",
            "groupIDs":["PigeonHit"],
            "sound":new Assets.PIGEON_HIT_2_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonHit3",
            "groupIDs":["PigeonHit"],
            "sound":new Assets.PIGEON_HIT_3_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonHit4",
            "groupIDs":["PigeonHit"],
            "sound":new Assets.PIGEON_HIT_4_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonHit5",
            "groupIDs":["PigeonHit"],
            "sound":new Assets.PIGEON_HIT_5_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonHitAway1",
            "groupIDs":["PigeonHitAway"],
            "sound":new Assets.PIGEON_HIT_AWAY_1_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonHitAway2",
            "groupIDs":["PigeonHitAway"],
            "sound":new Assets.PIGEON_HIT_AWAY_2_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonHitAway3",
            "groupIDs":["PigeonHitAway"],
            "sound":new Assets.PIGEON_HIT_AWAY_3_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonHitAway4",
            "groupIDs":["PigeonHitAway"],
            "sound":new Assets.PIGEON_HIT_AWAY_4_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonHitAway5",
            "groupIDs":["PigeonHitAway"],
            "sound":new Assets.PIGEON_HIT_AWAY_5_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonPanic1",
            "groupIDs":["PigeonPanic"],
            "sound":new Assets.PIGEON_PANIC_1_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonPanic2",
            "groupIDs":["PigeonPanic"],
            "sound":new Assets.PIGEON_PANIC_2_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonPanic3",
            "groupIDs":["PigeonPanic"],
            "sound":new Assets.PIGEON_PANIC_3_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonPanic4",
            "groupIDs":["PigeonPanic"],
            "sound":new Assets.PIGEON_PANIC_4_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonFlying",
            "sound":new Assets.PIGEON_FLYING_1_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonFlyingLoop",
            "sound":new Assets.PIGEON_FLYING_LOOP_1_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PigeonRustleFeathers",
            "sound":new Assets.PIGEON_RUSTLE_FEATHERS_1_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"FireCrackerExplode1",
            "groupIDs":["FireCrackerExplode"],
            "sound":new Assets.FIRECRACKER_1_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"FireCrackerExplode2",
            "groupIDs":["FireCrackerExplode"],
            "sound":new Assets.FIRECRACKER_2_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"FireCrackerExplode3",
            "groupIDs":["FireCrackerExplode"],
            "sound":new Assets.FIRECRACKER_3_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"FireCrackerExplode4",
            "groupIDs":["FireCrackerExplode"],
            "sound":new Assets.FIRECRACKER_4_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"FireCrackerExplode5",
            "groupIDs":["FireCrackerExplode"],
            "sound":new Assets.FIRECRACKER_5_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"FireCrackerExplode6",
            "groupIDs":["FireCrackerExplode"],
            "sound":new Assets.FIRECRACKER_6_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"FireCrackerThrow1",
            "groupIDs":["FireCrackerThrow"],
            "sound":new Assets.FIRECRACKER_THROW_1_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"BoomerangThrow5",
            "groupIDs":["BoomerangThrow"],
            "sound":new Assets.BOOMERANG_5_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"BoomerangThrow6",
            "groupIDs":["BoomerangThrow"],
            "sound":new Assets.BOOMERANG_6_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"BoomerangThrow7",
            "groupIDs":["BoomerangThrow"],
            "sound":new Assets.BOOMERANG_7_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"BoomerangThrow8",
            "groupIDs":["BoomerangThrow"],
            "sound":new Assets.BOOMERANG_8_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"WaterBalloonExplode5",
            "groupIDs":["WaterBalloonExplode"],
            "sound":new Assets.WATERBALLOON_5_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"VinylRecordExplode1",
            "groupIDs":["VinylRecordExplode"],
            "sound":new Assets.VINYL_RECORD_HIT_1_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"VinylRecordExplode2",
            "groupIDs":["VinylRecordExplode"],
            "sound":new Assets.VINYL_RECORD_HIT_2_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"VinylRecordExplode3",
            "groupIDs":["VinylRecordExplode"],
            "sound":new Assets.VINYL_RECORD_HIT_3_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"VinylRecordExplode4",
            "groupIDs":["VinylRecordExplode"],
            "sound":new Assets.VINYL_RECORD_HIT_4_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PooBombExplode1",
            "groupIDs":["PooBombExplode"],
            "sound":new Assets.BOMBER_POO_EXPLODE_1_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PooBombFire1",
            "groupIDs":["PooBombFire"],
            "sound":new Assets.BOMBER_POO_DROP_1_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PooBombFire2",
            "groupIDs":["PooBombFire"],
            "sound":new Assets.BOMBER_POO_DROP_2_SOUND() as Sound
         }));
         param1.register(new AudioParams({
            "audioID":"PooBombFire3",
            "groupIDs":["PooBombFire"],
            "sound":new Assets.BOMBER_POO_DROP_3_SOUND() as Sound
         }));
      }
   }
}

