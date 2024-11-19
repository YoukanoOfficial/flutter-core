import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  final String image;
  final Widget? imageBuilder;
  final String title;
  final Widget? titleBuilder;
  final String description;
  final Widget? descriptionBuilder;
  final String primaryTitle;
  final Widget? primaryBuilder;
  final Color? primaryColor;
  final VoidCallback? onPrimary;
  final String secondaryTitle;
  final Widget? secondaryBuilder;
  final Color? secondaryColor;
  final VoidCallback? onSecondary;

  const NoInternetWidget({
    Key? key,
    this.image = 'assets/images/no_internet_connection.png',
    this.imageBuilder,
    this.title = 'No Network Connection',
    this.titleBuilder,
    this.description =
        'No internet connection. Connect to the internet and try again.',
    this.descriptionBuilder,
    this.primaryTitle = 'Reload Page',
    this.primaryBuilder,
    this.primaryColor,
    this.onPrimary,
    this.secondaryTitle = 'Wifi Setting',
    this.secondaryBuilder,
    this.secondaryColor,
    this.onSecondary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: imageBuilder ??
                  Image.asset(
                    image,
                    width: 200,
                  ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: titleBuilder ??
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: descriptionBuilder ??
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (primaryBuilder != null)
                    Container(
                      child: primaryBuilder,
                    ),

                  if (primaryBuilder == null)
                    Container(
                      width: 125,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color?>(
                            primaryColor ?? Theme.of(context).primaryColor,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry?>(
                            const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                        onPressed: onPrimary,
                        child: Text(
                          primaryTitle,
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),

                  if (secondaryBuilder != null)
                    Container(
                      child: secondaryBuilder,
                    ),

                  if (secondaryBuilder == null)
                    Container(
                      width: 125,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color?>(
                            secondaryColor ?? Theme.of(context).primaryColor,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                            const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                        onPressed: onSecondary ?? () {
                          AppSettings.openAppSettings(type: AppSettingsType.wifi);
                        },
                        child: Text(
                          secondaryTitle,
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
