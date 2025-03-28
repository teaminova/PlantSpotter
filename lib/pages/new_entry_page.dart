import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../providers/journal_provider.dart';
import '../providers/images_provider.dart';
import '../widgets/privacy_switch.dart';

class NewEntryPage extends StatefulWidget {
  @override
  _NewEntryPageState createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isPublic = false;
  LatLng? _selectedLocation;
  bool noLocationSetError = false;
  bool noImageSetError = false;
  bool imageFromGallery = false;

  void toggleEntryPrivacy(bool value) {
    setState(() {
      _isPublic = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImagesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            imageProvider.removeImage();
            context.pop();
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF6B8E58),
          ),
        ),
        title: const Text('New Entry', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 125,
                    height: 125,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      image: imageProvider.image != null
                        ? DecorationImage(
                            image: FileImage(imageProvider.image!),
                            fit: BoxFit.cover,
                          )
                          : null,
                    ),
                    child: imageProvider.image == null
                      ? const Center(
                        child: Icon(
                          Icons.image,
                          size: 100,
                          color: Color(0xFFDFF2D4),
                        ),
                      )
                        : null,
                  ),

                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextButton(
                          onPressed: () {
                            imageProvider.takePhoto();
                            setState(() {
                              noImageSetError = false;
                              imageFromGallery = false;
                            });
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text('Take Photo'),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 200,
                        child: TextButton(
                          onPressed: () {
                            imageProvider.pickImage();
                            setState(() {
                              noImageSetError = false;
                              imageFromGallery = true;
                            });
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text('Choose From Gallery'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (noImageSetError == true)
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'Please set an image',
                    style: TextStyle(color: Color(0xFFB9362F), fontSize: 12),
                  ),
                ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Plant Name',
                  labelStyle: TextStyle(
                    color: Color(0xFF6B8E58),
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a plant name.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Date',
                  labelStyle: TextStyle(
                    color: Color(0xFF6B8E58),
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _dateController.text = selectedDate.toIso8601String().split('T')[0];
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: TextButton(
                      onPressed: () async {
                        final selectedLocation = await context.push<LatLng>('/set_location');
                        if (selectedLocation != null) {
                          setState(() {
                            _selectedLocation = selectedLocation;
                            noLocationSetError = false;
                          });
                        }
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text('Set Location'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(_selectedLocation != null
                      ? '${_selectedLocation!.latitude}\n${_selectedLocation!.longitude}'
                      : 'Location not set',
                      style: TextStyle(color: Color(0xFF6B8E58))),
                ],
              ),
              if (noLocationSetError == true)
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'Please set a location',
                    style: TextStyle(color: Color(0xFFB9362F), fontSize: 12),
                  ),
                ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Description',
                  labelStyle: TextStyle(
                    color: Color(0xFF6B8E58),
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              PrivacySwitch(
                isPublic: _isPublic,
                togglePrivacy: toggleEntryPrivacy,
              ),
              const Spacer(),
              SizedBox(
                width: 200,
                child: TextButton(
                  onPressed: () {
                    setState(() {});

                    if (_selectedLocation == null) {
                      setState(() {
                        noLocationSetError = true;
                      });
                    }

                    if (imageProvider.image == null) {
                      setState(() {
                        noImageSetError = true;
                      });
                    }

                    if (_formKey.currentState!.validate() && _selectedLocation != null && imageProvider.image != null) {
                      final provider = Provider.of<JournalProvider>(context, listen: false);
                      provider.addEntry(
                        imageFromGallery ? "assets/pine.png" : "assets/camera_photo.png",
                        _nameController.text,
                        DateTime.parse(_dateController.text),
                        _selectedLocation!,
                        _descriptionController.text,
                        _isPublic,
                      );

                      imageProvider.removeImage();

                      context.pop();
                    }
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Save Entry'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
