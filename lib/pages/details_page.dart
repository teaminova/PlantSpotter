import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../model/plant_entry.dart';
import '../providers/journal_provider.dart';
import '../services/auth_service.dart';

class DetailsPage extends StatefulWidget {
  final PlantEntry entry;

  const DetailsPage({required this.entry, Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late bool byUser = false;
  late bool isPublic;

  @override
  void initState() {
      super.initState();
      _initializeUser();
      isPublic = widget.entry.isPublic;
  }

  void _initializeUser() async {
    String? currentUser = await AuthService().getUsername();
    setState(() {
      byUser = widget.entry.user == currentUser;
    });
  }

  void toggleEntryPrivacy(bool value) {
      setState(() {
          isPublic = value;
      });

      Provider.of<JournalProvider>(context, listen: false).toggleEntryPrivacy(widget.entry, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            context.pop();
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF6B8E58),
          ),
        ),
        title: const Text('Details', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (byUser)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("PRIVATE", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF6B8E58))),
                    const SizedBox(width: 8),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 50,
                      height: 26,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isPublic ? Color(0xFF6B8E58) : Colors.black12,
                      ),
                      child: Stack(
                        alignment: isPublic ? Alignment.centerRight : Alignment.centerLeft,
                        children: [
                          Positioned(
                            left: isPublic ? 25 : 3,
                            child: GestureDetector(
                              onTap: () => toggleEntryPrivacy(!isPublic),
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.2),
                                      blurRadius: 3,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text("PUBLIC", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF6B8E58))),
                  ],
                ),
              ),

            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                widget.entry.image,
                width: 350,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(widget.entry.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF6B8E58))),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.entry.date.toLocal().toString().split(' ')[0],
                      style: const TextStyle(
                        color: Color(0xFF6B8E58),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.entry.description,
                      style: const TextStyle(
                        color: Color(0xFF6B8E58),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        widget.entry.user,
                        style: const TextStyle(
                          color: Color(0xFF6B8E58),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: TextButton(
                onPressed: () => context.push('/see_location', extra: widget.entry.location),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('See Location'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 200,
              child: TextButton(
                onPressed: () => context.push('/learn_more', extra: widget.entry.name),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Learn More'),
              ),
            ),
            // TextButton(
            //   onPressed: () => context.push('/see_location', extra: entry.location),
            //   child: const Text('See Location'),
            // ),
            // const SizedBox(height: 8),
            // TextButton(
            //   onPressed: () => context.push('/learn_more', extra: entry.name),
            //   child: const Text('Learn More'),
            // ),
          ],
        ),
      ),
    );
  }
}
