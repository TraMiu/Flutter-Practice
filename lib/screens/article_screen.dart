import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../models/words_provider.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  String selectedWord = '';
  final GlobalKey _textKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  TextSelection? _selection;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _showAddWordButton(BuildContext context, Offset position) {
    _removeOverlay();
    
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: position.dy,
        left: position.dx,
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Add "$selectedWord"?', 
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.add_circle, color: Colors.blue),
                  iconSize: 24,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    context.read<WordsProvider>().addWord(selectedWord.toLowerCase());
                    _removeOverlay();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added "$selectedWord" to vocabulary')),
                    );
                    setState(() {
                      selectedWord = '';
                    });
                    
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    _removeOverlay();
                    setState(() {
                      selectedWord = '';
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Offset _getSelectionPosition() {
    if (_selection == null || _textKey.currentContext == null) {
      return Offset.zero;
    }

    final RenderBox box = _textKey.currentContext!.findRenderObject() as RenderBox;
    final articleContent = context.read<WordsProvider>().articleContent;
    final TextPosition endPosition = TextPosition(offset: _selection!.extentOffset);
    
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: articleContent,
        style: TextStyle(fontSize: 18),
      ),
      textDirection: TextDirection.ltr,
      maxLines: null,
    );
    
    textPainter.layout(
      maxWidth: box.size.width,
      minWidth: 0,
    );
    
    final Offset localOffset = textPainter.getOffsetForCaret(endPosition, Rect.zero);
    final lineHeight = textPainter.preferredLineHeight;
    
    final Offset globalOffset = box.localToGlobal(Offset(
      localOffset.dx ,
      localOffset.dy + lineHeight * 2,
    ));
    
    final screenWidth = MediaQuery.of(context).size.width;
    final overlayWidth = 200; // approximate width of the overlay
    final adjustedDx = (globalOffset.dx + overlayWidth > screenWidth) 
        ? screenWidth - overlayWidth - 16 // 16 is padding
        : globalOffset.dx;

    return Offset(adjustedDx, globalOffset.dy);
    
    
  }

  @override
  Widget build(BuildContext context) {
    // Only access the provider once, store result in local variable
    final wordsProvider = Provider.of<WordsProvider>(context, listen: false);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Article'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final horizontalPadding = constraints.maxWidth > 600 ? 48.0 : 16.0;
          
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding, 
              vertical: 16.0
            ),
            child: Center(
              child: Container(
                // Constrain article width on wider screens for better readability
                constraints: BoxConstraints(maxWidth: 700),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'English Learning Article',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    // Use Consumer only for the text content that needs to rebuild
                    Consumer<WordsProvider>(
                      builder: (context, provider, _) {
                        return SelectableText(
                          provider.articleContent,
                          key: _textKey,
                          style: TextStyle(fontSize: 18, height: 1.5),
                          onSelectionChanged: (selection, cause) {
                            if (selection.baseOffset != selection.extentOffset) {
                              String text = provider.articleContent.substring(
                                selection.baseOffset,
                                selection.extentOffset,
                              );
                              
                              final cleanedText = text.trim().replaceAll(RegExp(r'[^\w\s]'), '');
                              
                              setState(() {
                                selectedWord = cleanedText;
                                _selection = selection;
                              });
                              
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (selectedWord.isNotEmpty) {
                                  _showAddWordButton(context, _getSelectionPosition());
                                }
                              });
                            } else {
                              setState(() {
                                selectedWord = '';
                              });
                              _removeOverlay();
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
