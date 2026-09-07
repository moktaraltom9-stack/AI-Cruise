import 'package:flutter/material.dart';
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
  final TextEditingController _promptController = TextEditingController();
  final List<String> _agentLogs = [];
  void _runAgentTask() {
    final text = _promptController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _agentLogs.insert(0, '🤖 جاري تنفيذ المهمة: "$text"');
      _promptController.clear();
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _agentLogs.insert(0, '✅ تم تحليل الطلب بنجاح وجاري البدء بالخطوات...');
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Cruise - وكيل الذكاء الاصطناعي'),
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepPurple.withOpacity(0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ماذا تريد أن أفعل لك اليوم؟',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _promptController,
                    decoration: InputDecoration(
                      hintText: 'مثلاً: اعمل لي فيديو عن كرة القدم وجهزه لـ TikTok...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      filled: true,
                      fillColor: const Color(0xFF2A2A2A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _runAgentTask,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('تشغيل الوكيل (Agent Mode)'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'سجل العمليات والنشاطات:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _agentLogs.isEmpty
                  ? const Center(
                      child: Text(
                        'لا توجد مهام نشطة حالياً. اكتب أمراً للبدء!',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _agentLogs.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: const Color(0xFF1A1A1A),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: const Icon(Icons.bolt, color: Colors.amber),
                            title: Text(_agentLogs[index], style: const TextStyle(fontSize: 14)),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
