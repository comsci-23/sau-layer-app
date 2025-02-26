import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sau_layer_app/presentation/model/nasa_history_model.dart';
import 'package:sau_layer_app/presentation/nasa_history/bloc/nasa_history_bloc.dart';
import 'package:sau_layer_app/presentation/nasa_history/page/nasa_detail_page.dart';
import 'package:google_fonts/google_fonts.dart';

class NasaHistoryPage extends StatefulWidget {
  const NasaHistoryPage({super.key});

  @override
  _NasaHistoryPageState createState() => _NasaHistoryPageState();
}

class _NasaHistoryPageState extends State<NasaHistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<NasaHistoryBloc>().add(const NasaHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NASA", style: GoogleFonts.poppins()),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(icon: Icon(Icons.send), onPressed: () {}),
        ],
      ),
      body: BlocBuilder<NasaHistoryBloc, NasaHistoryState>(
        builder: (context, state) {
          if (state is NasaHistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NasaHistoryError) {
            return Center(child: Text("Error: ${state.message}"));
          } else if (state is NasaHistoryHasData) {
            final data = state.model.items;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return _buildPostCard(data[index]);
              },
            );
          } else {
            return const Center(child: Text("No data available"));
          }
        },
      ),
    );
  }

  Widget _buildPostCard(NasaHistoryModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(item.imageUrl),
          ),
          title: const Text("NASA"),
          subtitle: Text("${DateTime.now().toLocal()}"),
          trailing: Icon(Icons.more_vert),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NasaDetailPage(nasaHistoryModel: item),
              ),
            );
          },
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(item.imageUrl, fit: BoxFit.cover),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.favorite_border), onPressed: () {}),
                  IconButton(icon: Icon(Icons.comment), onPressed: () {}),
                  IconButton(icon: Icon(Icons.send), onPressed: () {}),
                ],
              ),
              IconButton(icon: Icon(Icons.bookmark_border), onPressed: () {}),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            item.title,
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            item.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Divider(),
      ],
    );
  }
}
