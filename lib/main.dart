import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
void main() {
  runApp(const AICruiseApp());
}
class AICruiseApp extends StatelessWidget {
  const AICruiseApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Cruise',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
      ),
      home: const HomeScreen(),
    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _logs = [];
  // دالة فتح الواتساب وإرسال الرسالة
  Future<void> _openWhatsApp(String phone, String message) async {
    final Uri whatsappUri = Uri.parse("https://wa.me/$phone?text=${Uri.encodeComponent(message)}");
    try {
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
        setState(() {
          _logs.add("تم فتح الواتساب وإرسال الرسالة بنجاح!");
        });
      } else {
        setState(() {
          _logs.add("عذراً، لم يتم العثور على تطبيق الواتساب.");
        });
      }
    } catch (e) {
      setState(() {
        _logs.add("حدث خطأ: $e");
      });
    }
  }
  // تحليل الأمر المدخل وتوجيهه
  void _executeCommand(String command) {
    setState(() {
      _logs.add("الأمر: $command");
    });
    // لو الأمر يحتوي على كلمة واتساب أو إرسال
    if (command.contains("واتساب") || command.contains("whatsapp")) {
      // كمثال افتراضي، رقم ورسالة تجريبية، أو يمكن تحسينها لاحقاً لاستخراج الأرقام
      _openWhatsApp("+249900000000", "مرحباً، هذه رسالة تجريبية من تطبيق AI Cruise");
    } else {
      setState(() {
        _logs.add("تم استقبال الأمر ولكن ليس أمراً موجهاً للواتساب.");
      });
    }
    _controller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Cruise - Assistant'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
                ),
                child: ListView.builder(
                  itemCount: _logs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        _logs[index],
                        style: const TextStyle(color: Colors.white70),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'اكتب أمرك هنا (مثال: افتح واتساب)...',
                      filled: true,
                      fillColor: const Color(0xFF2C2C2C),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: Border.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.deepPurpleAccent),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _executeCommand(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
