
I use Lync 2010 at work and wanted to use orange as my default font color. The problem is that it’s not available through the settings dialog box. These are the options it gives me…

![lync2010_colors_dialog](/img/post/lync2010_colors_dialog.png)

No orange!?!

I figured the settings must be stored in the Windows Registry so I opened up the Registry Editor and navigated to the key [HKEY_CURRENT_USER\Software\Microsoft\Communicator]. There is a setting called “IM CharFormat” that stores the default font information. It is a binary value in the registry and you can modify it manually. If you look closely at the value the color is just an HTML HEX color code within this value. Here it is…

![lync2010_default_font_custom_color](/img/post/lync2010_default_font_custom_color.png)

All you need to do is get the HEX value for your custom color and update this part of the value with it. #F26522 is the orange color I want. You will have to completely close down Lync and then restart it after you save the registry value. Now open up the default font dialog in Lync again. You will see that your custom color is now being used.

![lync2010_colors_dialog_with_orange](/img/post/lync2010_colors_dialog_with_orange.png)

If you choose one of the other colors then the “Custom Color” option will go away and you’ll have to edit the registry again. If you edit the font type, size, or other options and keep the custom color selected it will stay.

The color picker in Lync 2013 is different and I believe you can select a custom color with it but you can still do this registry hack if you wish. It will also work with earlier versions of Lync/Communicator.


