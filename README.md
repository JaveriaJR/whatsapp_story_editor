Flutter package to add story editing features similar to Whatsapp. Make Stories like whatsapp and add texts, stickers, painting on your photo along with basic features like crop, rotation, and also add captions to it.

## How to Use
To use whatsapp_story_editor, follow the following steps:

### Step1: Adding plugin dependency
add the plugin to your pubspec.yaml file:

```yaml
whatsapp_story_editor: [latest_version]
```

### Step2: Importing the package.
import the plugin in [your_file].dart

```dart
import 'package:whatsapp_story_editor/whatsapp_story_editor.dart';
```

### Step3: Navigate to Whatsapp Story Editor Page
Navigate to WhatsappStortEditor Page on button click, you can find a whatsapp Camera button in the example file for reference. It will land you to the camera page which allows you to capture or select the photo from gallery upon your conscent.

```dart
 Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WhatsappStoryEditor()),
);
```


this returns an Object containing the edited photo and caption as Future<WhatsappStoryEditorResult> as:

```dart
  Navigator.push(
                context,
                MaterialPageRoute(
                      builder: (context) => const WhatsappStoryEditor()),
                ).then((whatsappStoryEditorResult) {
                  if (whatsappStoryEditorResult != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SavedImageView(
                                image: whatsappStoryEditorResult.image,
                                caption: whatsappStoryEditorResult.caption,
                              )),
                    );
                }
                });
);
```

Note that the whatsappStoryEditorResult could be null if the user dosnt makes any edit on the photo and leaves. [SavedImageView](https://pub.dev/packages/whatsapp_story_editor/example/saved_image_view.dart) is the page where you could show the edited photo and caption. You may change as you need it to be.


### Example
Please refer to the example file for detailed usage and example [here](https://pub.dev/packages/whatsapp_story_editor/example)


## Example Images:
 
 <img src="https://imgur.com/wNx4dfd.png" width="180" />  <img src="https://imgur.com/tZRqrAm.png" width="180" />  <img src="https://imgur.com/cTdIMd6.png" width="180" />  <img src="https://imgur.com/3cynFSd.png" width="180" />  <img src="https://imgur.com/yHXWekp.png" width="180" /> <img src="https://imgur.com/lgExybA.png" width="180" /> <img src="https://imgur.com/nJj8bdU.png" width="180"/> <img src="https://imgur.com/g1cshOZ.png" width="180" /> <img src="https://imgur.com/iGUJrJO.png" width="180" /> <img src="https://imgur.com/9RhJZZO.png" width="180" /> <img src="https://imgur.com/VsaTpIF.png" width="180" /> <img src="https://imgur.com/PHTO5IB.png" width="180" /> <img src="https://imgur.com/i6RBM88.png" width="180" /> <img src="https://imgur.com/u660duD.png" width="180" /> 
 


Created by [Javeria Iffat](https://www.linkedin.com/in/javeria-iffat/)

## Future Work
For now, only one image editing capability is being handled by Whatsapp Story Editor in this version.

## FAQ

In case you need: to add new feature or you get any error or any help, please contact me at javeriaiffat312@gmail.com or javeria.iffat@lums.edu.pk
please be kind if you get any errors, text me I'll be more than happy to help you all.

THANK YOU!