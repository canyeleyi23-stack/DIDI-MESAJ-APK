import 'package:flutter/material.dart';

void main() {
  runApp(const DidiMesajApp());
}

class DidiMesajApp extends StatelessWidget {
  const DidiMesajApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DİDİ MESAJ',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0;

  final chats = const [
    ('Ahmet', 'Merhaba, nasılsın?', '12:42', true),
    ('Mehmet', 'DİDİ MESAJ hazır.', '11:30', false),
    ('Ayşe', 'Akşam konuşalım.', 'Dün', true),
    ('DİDİ Grup', 'Yeni mesajlarınız var', 'Pzt', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DİDİ MESAJ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(
        index: selected,
        children: [
          _chatsPage(),
          _contactsPage(),
          _callsPage(),
          _settingsPage(),
        ],
      ),
      floatingActionButton: selected == 0
          ? FloatingActionButton(
              onPressed: () {
                _openChat('Yeni Sohbet');
              },
              child: const Icon(Icons.chat),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        onDestinationSelected: (index) {
          setState(() => selected = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Mesajlar',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Kişiler',
          ),
          NavigationDestination(
            icon: Icon(Icons.call_outlined),
            selectedIcon: Icon(Icons.call),
            label: 'Aramalar',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Ayarlar',
          ),
        ],
      ),
    );
  }

  Widget _chatsPage() {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];

        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          leading: CircleAvatar(
            radius: 27,
            child: Text(
              chat.$1.substring(0, 1),
              style: const TextStyle(fontSize: 20),
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  chat.$1,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                chat.$3,
                style: TextStyle(
                  fontSize: 12,
                  color: chat.$4 ? Colors.blue : Colors.grey,
                ),
              ),
            ],
          ),
          subtitle: Row(
            children: [
              Expanded(
                child: Text(
                  chat.$2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (chat.$4)
                const Icon(
                  Icons.done_all,
                  size: 17,
                  color: Colors.blue,
                ),
            ],
          ),
          onTap: () => _openChat(chat.$1),
        );
      },
    );
  }

  Widget _contactsPage() {
    final contacts = ['Ahmet', 'Mehmet', 'Ayşe', 'Can', 'DİDİ Destek'];

    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
          child: Text(
            'Kişiler',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        ...contacts.map(
          (name) => ListTile(
            leading: CircleAvatar(
              child: Text(name.substring(0, 1)),
            ),
            title: Text(name),
            subtitle: const Text('DİDİ MESAJ kullanıcısı'),
            trailing: IconButton(
              icon: const Icon(Icons.chat_outlined),
              onPressed: () => _openChat(name),
            ),
          ),
        ),
      ],
    );
  }

  Widget _callsPage() {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
          child: Text(
            'Aramalar',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: const Text('Ahmet'),
          subtitle: const Text('Gelen arama • Bugün 12:10'),
          trailing: IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
        ),
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: const Text('Mehmet'),
          subtitle: const Text('Görüntülü arama • Dün'),
          trailing: IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _settingsPage() {
    return ListView(
      children: [
        const SizedBox(height: 20),
        const ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Icon(Icons.person, size: 30),
          ),
          title: Text(
            'DİDİ MESAJ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text('Profil ve hesap'),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.notifications_outlined),
          title: const Text('Bildirimler'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.lock_outline),
          title: const Text('Gizlilik'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.storage_outlined),
          title: const Text('Depolama'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('DİDİ MESAJ hakkında'),
          subtitle: const Text('Sürüm 1.1.0'),
          onTap: () {},
        ),
      ],
    );
  }

  void _openChat(String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatPage(name: name),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final String name;

  const ChatPage({super.key, required this.name});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();

  final messages = <String>[
    'Merhaba 👋',
    'DİDİ MESAJ hoş geldin.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 19,
              child: Icon(Icons.person, size: 21),
            ),
            const SizedBox(width: 10),
            Text(widget.name),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: index.isEven
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      color: index.isEven
                          ? Colors.grey.shade200
                          : Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      messages[index],
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 5, 8, 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Mesaj yaz...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 18),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  FloatingActionButton.small(
                    onPressed: () {
                      final text = controller.text.trim();
                      if (text.isEmpty) return;

                      setState(() {
                        messages.add(text);
                        controller.clear();
                      });
                    },
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
