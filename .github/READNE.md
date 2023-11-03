Language: 　**English**　|　[日本語](./README_jp.md)

# CatMaid (猫メイド)
This is "Cat maid (猫メイド)", the avatar for [Figura](https://modrinth.com/mod/figura), the skin mod for [Minecraft](https://www.minecraft.net/en-us).

Target Figura versions: [0.1.1](https://modrinth.com/mod/figura/version/0.1.1+1.20.1-0f8b7a9)~

![Main image](./README_Images/main.jpg)

## Features
- Has cat ears, cat tail, and maid skirt.
  - The ears are sometimes animated.
  - The tail wags left and right (can be disabled in [avatar settings](#avatar-settings)).

	![Wag tail](./README_Images/wag_tail.gif)

  - The tail stands or dropped depending on the player's health and saturation.

	![Dropping tail](./README_Images/drop_tail.jpg)

- Sometimes meows.
  - Opens mouth when meowing.
  - Her meow changes when low health and saturation.

- Sometimes the ears move.
  - Which one moves is depend on the player's dominant hand.

- Sometimes blinks.
- Her expression will change when taking a damage, low health, or low saturation.

- Smiles or winks in [the action wheel](#the-action-wheel).

  ![Smile](./README_Images/action_smile.gif)

  ![Wink](./README_Images/action_wink.gif)

- Players bell sounds when walking and jumping (can be disabled in [avatar settings](#avatar-settings)).
  - The volume of bell sounds will be reduced to 1/5 when sneaking.

- Plays cat hurts sounds when taking a damage.

- The eyes shine when holding the favorite foods. Satisfies and meows when eating them.

  ![The favorite food](./README_Images/favorite_food.gif)

- Pales when she is sick or eat something inedible.

  ![Pale](./README_Images/pale.gif)

- Sleeps like a cat at bedtime.
  - The view at bedtime ws also changed to match the pose.
  - Purrs at bedtime.

	![Sleeping](./README_Images/sleep.jpg)

- Holds a cake like a maid.
  - The design of the cake is occasionally changed.

  ![Hold a cake](./README_Images/cake.jpg)

- Gets wet when touching water.
  - Can flick water droplets off the body by shaking the body.

  ![Getting wet](./README_Images/wet.gif)

- Will be frightened and tremble when a [warden](https://minecraft.wiki/w/Warden) is nearby her (≒ has the darkness effect).

  ![Scared of warden](./README_Images/scared_of_warden.jpg)

  - Holds the ball not to make sounds and refuses playing animations when she is frightened.

    ![Refusing animations](./README_images/refuse_animation.gif)

- Plays animations when being left alone for a short while (can be disabled in [avatar settings](#avatar-settings)).

  - Touches her bell every 30 seconds.

  ![Touch bell](./README_Images/touch_bell.gif)

  - Falls asleep after 5 minutes have passed since she was left alone.

  ![Doze](./README_Images/doze.gif)

  ![Fall asleep](./README_Images/doze2.gif)

  ![Back from AFK](./README_Images/afk.gif)

- Glows the eyes like a cat when the player has a night vision effect.
  - You cannot see the glowing eyes by yourself because of night vision specifications.
  - Use a shader pack if you really want to check them.

  ![Glowing eyes](./README_Images/glow_eyes.jpg)

- The hair flutters with the player's movement.

  ![Fluttering hair](./README_Images/flutter_hair.gif)

- Has various types of ears and tail textures based on vanilla cats. You can change them in [avatar settings](#avatar-settings).

  ![Various tails](./README_Images/various_tails.jpg)

- Has a summer features! Changes her costume to swimsuit when enabled.
  - Changes a leather helmet to a summer hat.
  - Changes a turtle shell to a snorkel.
    - Raises the snorkel when out of water.

## The action wheel
Figura provides the action wheel with which players can play some actions (emotes, animations, configs, and etc.). It will be shown when holding the action wheel key (default is B key). This avatar also has some actions.

### Page 1

![Action wheel 1](./README_Images/action_wheel_1.jpg)

#### Action 1-1. Smile
Meows and smiles.

![Smile](./README_Images/action_smile.gif)

#### Action 1-2. Wink
Meows and winks.

![Wink](./README_Images/action_wink.gif)

#### Action 1-3. Shining eyes
Meows and shines her eyes.

![Shining eyes](./README_Images/action_shine_eyes.gif)

#### Action 1-4. Unequaled eyes
Meows and shows unequaled eyes with full of joy.

![Unequaled eyes](./README_Images/action_unequal_eyes.gif)

#### Action 1-5. Surprised
Surprised and sweats. Right-click to pale.

![Surprised](./README_Images/action_surprised.gif)

#### Action 1-6. Intimidate
Intimidates against enemies. The hairs on the tail stand on the end. Left-click to intimidate softly, Right-click to intimidate hard.

![Intimidate](./README_Images/action_intimidate.gif)

#### Action 1-7. Downhearted
Downhearted. Right-click to pale.

![Downhearted](./README_Images/action_downhearted.gif)

### Page 2

![Action wheel 2](./README_Images/action_wheel_2.jpg)

#### Action 2-1. Pat (head)
You will pat her head (The displayed arm will be your skin).

![Pats head](./README_Images/action_pat_head.gif)

#### Action 2-2. Pat (tails)
You will pat her tail (The displayed arm will be your skin). This makes her angry because cats hate being touched their tails.

![Pats tail](./README_Images/action_pat_tail.gif)

#### Action 2-3. Sitting down
Sits down there. She will stand up when playing this action again. She will also stand up when moving, jumping, or sneaking while setting down.

![Shitting down](./README_Images/action_sit_down.jpg)

#### Action 2-4. Body shaking
Shakes her body. This action can flick water droplets off the body when getting out of water/rain.

![Shaking body](./README_Images/action_body_shaking.gif)

#### Action 2-5. Toggle summer feature
Toggles summer feature.

#### Action 2-7. Open avatar settings
Opens [avatar settings](#avatar-settings).

## Avatar settings
You can open this avatar settings by clicking [action 2-7](#action-2-7-open-avatar-settings). You can close it by closing the action wheel once.

![Avatar settings](./README_Images/avatar_settings.jpg)

### Action 1. Ears and tail type
Changes type of the ears and tail. Scroll to select the option and close the action wheel to confirm.

![Cat types](./README_Images/various_tails.jpg)

### Action 2. Change volume of bell sounds
Changes the volume of bell sounds. Scroll to increase or decrease in 5% increments and close the action wheel to confirm.

### Action 3. Toggle cat's meow
Toggles whether periodic cat's meows are played or not.

### Action 4. Toggle tail wagging
Toggles if the avatar wags its tail or not.

### Action 5. Toggle armors visible
Toggles whether equipped armors are visible or not. The maid skirt will be hidden not to interfere with the armors while equips them. This setting will only affects to vanilla armors.

### Action 6. Toggle auto body shaking
Toggles whether [the avatar shakes its body](#action-2-4-body-shaking) or not when getting wet.

### Action 7. Toggle afk actions
Toggles if afk actions are played or not.

![Fall asleep](./README_Images/doze2.gif)

## How to use
Figura is available in [Forge](https://files.minecraftforge.net/net/minecraftforge/forge/), [Fabric](https://fabricmc.net/), and [Quilt](https://quiltmc.org/).

1. Install the mod loader which you want to use and make the mods available.
2. Install [Figura](https://modrinth.com/mod/figura). Note the mod dependencies.
3. Go to the download page for the character which you want to download.
4. Click green "**<>Code**" button at the top of the page and "**Download ZIP**" to download the repository files (or clone this repository).
5. Extract the file if it is a zipped file.
6. Put avatar files at `<minecraft_instance_directory>/figura/avatars/`.
   - The directory will automatically generated after launching the game with Figura installed. You can also create it manually if it doesn't exist.
7. Open the Figura menu (Δ mark) from the game menu.
8. Select the avatar from the avatar list at the left of the Figura menu.
9. Sets your permission if you need.
10. Other Figura players can see your avatar after uploading your avatar to the Figura server.

## Notes
- I'm not responsible for any damages caused by using this avatar.
- This avatar is designed for work with no resource pack and no other mods are installed. An unexpected issue may occurs when you use it with any resource packs and mods (texture and armor inconsistencies, etc.). However, I won't support in these cases.
- Please [report an issue](https://github.com/Gakuto1112/CatMaid/issues) if you find it.