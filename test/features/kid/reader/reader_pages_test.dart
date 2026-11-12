import 'package:flutter_test/flutter_test.dart';
import 'package:ai_storytelling_mobile/features/kid/reader/reader_pages.dart';
import 'package:ai_storytelling_mobile/models/reading_content_dto.dart';
import 'package:ai_storytelling_mobile/models/reading_segment_dto.dart';

void main() {
  group('Trang đọc truyện', () {
    test(
      'cảnh có 2 tranh hợp lệ trả 2 trang cùng sceneIndex, savePage = sceneIndex + 1 và pageText nối lại đúng',
      () {
        const sceneIndex = 0;
        const text = 'Trang thu 1!Trang thu 2!';
        final content = ReadingContentDto(
          sessionId: 1,
          storyId: 1,
          scenes: [
            ReadingSceneDto(
              sceneId: 10,
              sceneIndex: sceneIndex,
              text: text,
              illustrations: const [
                SceneIllustrationDto(
                  beatOrder: 0,
                  startOffset: 0,
                  endOffset: 12,
                  url: 'https://example.com/pic1.png',
                ),
                SceneIllustrationDto(
                  beatOrder: 1,
                  startOffset: 12,
                  endOffset: 24,
                  url: 'https://example.com/pic2.png',
                ),
              ],
            ),
          ],
        );

        final pages = buildReaderPages(content);

        expect(pages.length, 2);
        expect(pages[0].sceneIndex, sceneIndex);
        expect(pages[1].sceneIndex, sceneIndex);
        expect(pages[0].savePage, sceneIndex + 1);
        expect(pages[1].savePage, sceneIndex + 1);
        expect(pages[0].imageUrl, 'https://example.com/pic1.png');
        expect(pages[1].imageUrl, 'https://example.com/pic2.png');
        expect('${pages[0].pageText}${pages[1].pageText}', equals(text.trim()));
      },
    );

    test(
      'cảnh không có illustrations nhưng có illustrationUrl trả 1 trang với imageUrl và pageText đầy đủ',
      () {
        const text = 'Một ngày đẹp trời ở vương quốc cổ tích.';
        const illustrationUrl = 'https://example.com/single.png';
        final content = ReadingContentDto(
          sessionId: 1,
          storyId: 1,
          scenes: const [
            ReadingSceneDto(
              sceneId: 1,
              sceneIndex: 0,
              text: text,
              illustrationUrl: illustrationUrl,
              illustrations: [],
            ),
          ],
        );

        final pages = buildReaderPages(content);

        expect(pages.length, 1);
        expect(pages.first.imageUrl, equals(illustrationUrl));
        expect(pages.first.pageText, equals(text));
      },
    );

    test(
      'cảnh không có illustrations và illustrationUrl null trả 1 trang với imageUrl null',
      () {
        const text = 'Cảnh chỉ có văn bản và không có hình minh họa.';
        final content = ReadingContentDto(
          sessionId: 1,
          storyId: 1,
          scenes: const [
            ReadingSceneDto(
              sceneId: 1,
              sceneIndex: 0,
              text: text,
              illustrationUrl: null,
              illustrations: [],
            ),
          ],
        );

        final pages = buildReaderPages(content);

        expect(pages.length, 1);
        expect(pages.first.imageUrl, isNull);
        expect(pages.first.pageText, equals(text));
      },
    );

    test(
      'hai cảnh (sceneIndex 0 và 1) có tổng số trang bằng tổng số tranh và sắp theo sceneIndex',
      () {
        final content = ReadingContentDto(
          sessionId: 1,
          storyId: 1,
          scenes: const [
            ReadingSceneDto(
              sceneId: 2,
              sceneIndex: 1,
              text: 'Cảnh hai đoạn 1.Cảnh hai đoạn 2.',
              illustrations: [
                SceneIllustrationDto(
                  beatOrder: 0,
                  startOffset: 0,
                  endOffset: 16,
                  url: 'https://example.com/s2_1.png',
                ),
                SceneIllustrationDto(
                  beatOrder: 1,
                  startOffset: 16,
                  endOffset: 32,
                  url: 'https://example.com/s2_2.png',
                ),
              ],
            ),
            ReadingSceneDto(
              sceneId: 1,
              sceneIndex: 0,
              text: 'Cảnh một chỉ có một tranh.',
              illustrationUrl: 'https://example.com/s1.png',
            ),
          ],
        );

        final pages = buildReaderPages(content);

        expect(pages.length, 3);
        expect(pages.map((p) => p.sceneIndex).toList(), equals([0, 1, 1]));
      },
    );

    test(
      'indexForLastPage với pages có savePage 1, 1, 2: lastPage 2 trả về 2, lastPage 9 trả về 0',
      () {
        const scene0 = ReadingSceneDto(sceneId: 1, sceneIndex: 0);
        const scene1 = ReadingSceneDto(sceneId: 2, sceneIndex: 1);

        final pages = [
          const ReaderPage(
            scene: scene0,
            pictureIndex: 0,
            pictureCount: 2,
            imageUrl: null,
            text: '',
            textStart: 0,
            textEnd: 0,
            segments: [],
          ),
          const ReaderPage(
            scene: scene0,
            pictureIndex: 1,
            pictureCount: 2,
            imageUrl: null,
            text: '',
            textStart: 0,
            textEnd: 0,
            segments: [],
          ),
          const ReaderPage(
            scene: scene1,
            pictureIndex: 0,
            pictureCount: 1,
            imageUrl: null,
            text: '',
            textStart: 0,
            textEnd: 0,
            segments: [],
          ),
        ];

        expect(pages.map((p) => p.savePage).toList(), equals([1, 1, 2]));
        expect(indexForLastPage(pages, 2), equals(2));
        expect(indexForLastPage(pages, 9), equals(0));
      },
    );

    test(
      'splitByVocabulary tách đúng đoạn thường và từ vựng, xử lý không khớp và không phân biệt hoa thường',
      () {
        // Trường hợp 1: Tách từ vựng khớp
        final spans = splitByVocabulary(
          'Ếch nhảy lên lá sen',
          const [ReadingVocabularyDto(id: 7, term: 'lá sen')],
        );
        expect(
          spans,
          equals(const [
            VocabSpan(text: 'Ếch nhảy lên ', vocabularyId: null),
            VocabSpan(text: 'lá sen', vocabularyId: 7),
          ]),
        );

        // Trường hợp 2: Không khớp -> một đoạn duy nhất
        final spansNoMatch = splitByVocabulary(
          'Ếch nhảy lên lá sen',
          const [ReadingVocabularyDto(id: 8, term: 'hoa súng')],
        );
        expect(
          spansNoMatch,
          equals(const [
            VocabSpan(text: 'Ếch nhảy lên lá sen', vocabularyId: null),
          ]),
        );

        // Trường hợp 3: Không phân biệt hoa thường: 'LÁ SEN'
        final spansCase = splitByVocabulary(
          'Ếch nhảy lên LÁ SEN',
          const [ReadingVocabularyDto(id: 7, term: 'lá sen')],
        );
        expect(
          spansCase,
          equals(const [
            VocabSpan(text: 'Ếch nhảy lên ', vocabularyId: null),
            VocabSpan(text: 'LÁ SEN', vocabularyId: 7),
          ]),
        );
      },
    );
  });
}
