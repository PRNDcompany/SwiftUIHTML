//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI
import Testing

@testable import SwiftUIHTML
@testable import SwiftUIHTMLExample
import SnapshotTesting

class HTMLBasicTests {
    
    @MainActor
    @Test(arguments: [LineBreakMode.byWordWrapping, LineBreakMode.byCharWrapping])
    func testingBasicHTMLElements(lineBreakMode: LineBreakMode) async throws {
        let html = """
        <header>
            <h1>Testing Basic HTML Elements</h1>
            <p>This is an example showcasing various fundamental HTML elements.</p>
        </header>
        
        <main>
            <section>
                <h2>Text-related Elements</h2>
                <p>Testing <strong>strong</strong> and <em>emphasized</em> text.<br>Also, checking line breaks (`&lt;br&gt;`).</p>
                <p>Testing multiple line breaks:<br><br>Text remains visible after two line breaks.</p>
            </section>
        
            <section>
                <h2>Links and Styles</h2>
                <p>Here's text with <span style="color: blue;">applied styles</span> and <a href="https://example.com" target="_blank">a link that opens in a new tab</a>.</p>
            </section>
        
            <section>
                <h2>List-related Elements</h2>
                <p>An example of an unordered list:</p>
                <ul>
                    <li>First item</li>
                    <li>Second item</li>
                    <li>Third item</li>
                </ul>
            </section>
        
            <section>
                <h2>Inline Elements Test</h2>
                <p>Testing the rendering of multiple inline elements (<span>span</span>, <strong>strong</strong>, <em>em</em>) used consecutively.</p>
            </section>
        </main>
        
        <footer>
            <p>&copy; 2025 Basic HTML Test Page</p>
        </footer>
        """
        let view = HTMLView(html: html, parser: HTMLFuziParser())
            .htmlEnvironment(\.configuration, .sample)
            .htmlEnvironment(\.styleContainer, .sample(by: lineBreakMode))
            .frame(width: 375)
            .fixedSize(horizontal: true, vertical: false)

        assertSnapshot(of: view, as: .image, named: "\(lineBreakMode)")
    }

    @MainActor
    @Test(arguments: [LineBreakMode.byCharWrapping, LineBreakMode.byWordWrapping])
    func testingLineBreak(lineBreakMode: LineBreakMode) async throws {
        let html = """
        <p>1인 소유, 파노라믹 글라스 루프, 열선핸들
        롱 레인지 트림으로 더욱 긴 거리를 운행할 수 있습니다.
        외관과 실내 컨디션이 깔끔한 차량입니다.
        파노라믹 글라스 루프가 적용되어 개방감 있는 가능합니다.</p>
        <p>1인 소유, 파노라믹 글라스 루프, 열선핸들
        롱 레인지 트림으로 더욱 긴 거리를 운행할 수 있습니다?
        외관과 실내 컨디션이 깔끔한 차량입니다.
        파노라믹 글라스 루프가 적용되어 개방감 있는 가능합니다.</p>
        <p>1인 소유, 파노라믹 글라스 루프, 열선핸들
        롱 레인지 트림으로 더욱 긴 거리를 운행할 수 있습니다.
        외관과 실내 컨디션이 깔끔한 차량입니다.
        파노라믹 글라스 루프가 적용되어 개방감 있는 가능합니다.</p>
        """
        let view = HTMLView(html: html, parser: HTMLFuziParser())
            .htmlEnvironment(\.configuration, .sample)
            .htmlEnvironment(\.styleContainer, .sample(by: lineBreakMode))
            .frame(width: 233, alignment: .leading)
            .fixedSize(horizontal: true, vertical: false)
        assertSnapshot(of: view, as: .image, named: "\(lineBreakMode)")
    }

    @MainActor
    @Test(arguments: [(375, LineBreakMode.byCharWrapping), (375, LineBreakMode.byWordWrapping)])
    func testHTMLImageAndNesting(width: CGFloat, lineBreakMode: LineBreakMode) async throws {
        let html = """
        <header>
            <h1>Testing HTML Structure with Image and Nesting</h1>
            <p>This example includes an image and demonstrates block and inline element nesting.</p>
        </header>
        
        <main>
            <section>
                <h2>Image Element</h2>
                <p>Here's an image:</p>
                <!-- <img src="https://picsum.photos/id/237/200/300" width="200"> -->
                <p>The image should appear above this text.</p>
            </section>
        
            <section>
                <h2>Inline Image Element</h2>
                <p>This text contains an inline image: <img src="https://picsum.photos/id/237/50/50" width="8" height="8" alt="Small inline image"> This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: Thinline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image:<img src="https://picsum.photos/id/12/50/50" width="4" height="4" alt="Small inline image"> This text contains an inline image: This text contains an inline image: Thinline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: Thinline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: Thinline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: This text contains an inline image: <img src="https://picsum.photos/id/237/50/50" width="50" height="50" alt="Small inline image"> and continues after it.</p>
                <p>Another paragraph with an inline image <img src="https://picsum.photos/id/100/50/50" width="50" height="50" alt="Another small inline image"> within the text flow. This text contains an inline image: <img src="https://picsum.photos/id/237/50/50" width="50" height="50" alt="Small inline image"> and continues after it. Another paragraph with an inline image <img src="https://picsum.photos/id/100/50/50" width="50" height="50" alt="Another small inline image"> within the text flow.</p> 
            </section>
        
           <section>
               <h2>Block inside Inline (with markers)</h2>
               <p>Inline start <span>contains block <div>This is a block inside an inline.</div></span> inline end.</p>
               <p>This tests how inline elements handle nested block elements with visual markers.</p>
           </section>
        
           <section>
               <h2>Inline inside Block inside Inline (with markers)</h2>
               <p>Inline start <span>contains block <div>which contains inline <em>This is inline inside block inside inline.</em></div></span> inline end.</p>
               <p>This tests deeper nesting with visual markers.</p>
           </section>
        
            <section>
                <h2>List with Inline Elements</h2>
                <p>A list containing inline elements:</p>
                <ul>
                    <li>First item with <strong>strong</strong> text.</li>
                    <li>Second item with <em>emphasized</em> text and a <span>styled</span> part.</li>
                    <li>Third item with a <a href="#">link</a>.</li>
                </ul>
            </section>
        </main>
        
        <footer>
            <p>&copy; 2025 HTML Nesting Test Page</p>
        </footer>
        """
        let view = HTMLView(html: html, parser: HTMLFuziParser())
            .htmlEnvironment(\.configuration, .sample)
            .htmlEnvironment(\.styleContainer, .sample(by: lineBreakMode))
            .frame(width: width)
            .fixedSize(horizontal: false, vertical: true)

        try? await ViewSnapshotTester.snapshot(
            of: view,
            named: "\(Int(width)),\(lineBreakMode)",
            sleep: .seconds(2)
        )
    }

    @MainActor
    @Test()
    func testHTMLImageWithLineHeight() async throws {
        let html = """
        <p>
        <span style="font-family: 'SpoqaHanSansNeo-Regular'"> 가나다라ja <img src="https://picsum.photos/id/237/24/24" width="24" height="32" > </span>
        <span style="font-family: 'SpoqaHanSansNeo-Regular'"> 가나다라ja <img src="https://picsum.photos/id/237/24/24" width="24" height="24" > </span>
        <span style="font-family: 'SpoqaHanSansNeo-Regular'"> 가나다라ja12 <img src="https://picsum.photos/id/237/12/12" width="12" height="12" > </span>
        </p>
        """
        let view = HTMLView(html: html, parser: HTMLFuziParser())
            .htmlEnvironment(\.configuration, .sample)
            .htmlEnvironment(\.styleContainer, .sample(by: .byCharWrapping))
            .frame(width: 375)
            .background(alignment: .top) {
                ZStack(alignment: .topLeading) {
                    Color.yellow.frame(height: 24).opacity(0.4)
                    Color.red.frame(height: 32).opacity(0.4)
                    Color.green.frame(height: 24).opacity(0.4)
                        .padding(.top, 8)
                }
            }
            .fixedSize(horizontal: false, vertical: true)

        try? await ViewSnapshotTester.snapshot(
            of: view,
            sleep: .seconds(3)
        )
    }


    @MainActor
    @Test(arguments: [LineBreakMode.byWordWrapping, LineBreakMode.byCharWrapping])
    func testingStyleHTMLElements(lineBreakMode: LineBreakMode) async throws {
        let html = """
        <header>
            <h1>Testing <span style="color: yellow; font-family: 'serif'">Basic</span> HTML Elements</h1>
            <p>This is an example showcasing various fundamental HTML elements.</p>
        </header>
        
        <main>
            <section style="padding: 10px; margin: 20px 20px 20px 20px; background: red;">
                <h2 style="padding: 10px; margin: 8px; background: green; color: white;">Text-related Elements</h2>
                <p>Testing <strong>strong</strong> and <em>emphasized</em> text.<br>Also, checking line breaks (`&lt;br&gt;`).</p>
                <p>Testing multiple line breaks:<br><br>Text remains visible after two line breaks.</p>
            </section>
        
            <section style="background-color: #f5f5f5; border: 1px solid #ddd; border-radius: 8px; padding: 20px;">
                <h2>Links and Styles</h2>
                <p>Here's text with <span style="color: red; background-color: #ffeeee; border-radius: 4px; padding: 2px 5px;">applied styles</span> and <a href="https://example.com" target="_blank" style="background-color: #e0f0ff; border: 1px solid #0066cc; border-radius: 3px; padding: 2px 6px; text-decoration: none; color: #0066cc;">a link that opens in a new tab</a>.</p>
            </section>
        
            <section style="background-color: #f9f9f9; box-shadow: 0 4px 8px rgba(0,0,0,0.1); border-radius: 8px; padding: 20px; margin: 15px 0;">
               <h2 style="color: #333; border-bottom: 2px solid #eaeaea; padding-bottom: 10px;">List-related Elements</h2>
               <p>An example of an unordered list:</p>
               <ul style="background-color: white; border-radius: 6px; padding: 8px 16px; box-shadow: inset 0 0 5px rgba(0,0,0,0.5); margin-top: 16px;">
                   <li style="padding: 8px 0;">First item</li>
                   <li style="padding: 8px 0;">Second item</li>
                   <li style="padding: 8px 0;">Third item</li>
               </ul>
            </section>
        
            <section>
                <h2>Inline Elements Test</h2>
                <p>Testing the rendering of multiple inline elements (<span>span</span>, <strong>strong</strong>, <em>em</em>) used consecutively.</p>
            </section>
        </main>
        
        <footer>
            <p>&copy; 2025 Basic HTML Test Page</p>
        </footer>
        """
        let view = HTMLView(html: html, parser: HTMLFuziParser())
            .htmlEnvironment(\.configuration, .sample)
            .htmlEnvironment(\.styleContainer, .sample(by: lineBreakMode))
            .frame(width: 375)
            .fixedSize(horizontal: true, vertical: false)
        assertSnapshot(of: view, as: .image, named: "\(lineBreakMode)")
    }

    @MainActor
    @Test("Image Position and Line Height Test")
    func testImagePositionAndLineHeight() async throws {
        let html = """
        <h2>Image Position and Line Height Test</h2>
        
        <p>Various sized inline image test:
        Text with <img src="https://picsum.photos/id/100/8/8" width="8" height="8" /> 8px image,
        <img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> 16px image,
        <img src="https://picsum.photos/id/106/24/24" width="24" height="24" /> 24px image,
        <img src="https://picsum.photos/id/108/32/32" width="32" height="32" /> 32px image embedded naturally.</p>
        
        <p style="line-height: 24px;">Line height 24px test:
        <img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> 16px image and
        <img src="https://picsum.photos/id/108/32/32" width="32" height="32" /> 32px image
        to verify how they affect line height alignment.</p>
        
        <p>Consecutive images: <img src="https://picsum.photos/id/102/16/16" width="16" height="16" /><img src="https://picsum.photos/id/104/20/20" width="20" height="20" /><img src="https://picsum.photos/id/106/24/24" width="24" height="24" /> positioned adjacently like this.</p>
        """
        
        let view = HTMLView(html: html, parser: HTMLFuziParser())
            .htmlEnvironment(\.configuration, .sample)
            .htmlEnvironment(\.styleContainer, .sample(by: .byWordWrapping))
            .frame(width: 375)
            .fixedSize(horizontal: false, vertical: true)

        try? await ViewSnapshotTester.snapshot(
            of: view,
            named: "imagePositionAndLineHeight",
            sleep: .seconds(2)
        )
    }

    @MainActor
    @Test("Non-English Text with Images")
    func testNonEnglishTextWithImages() async throws {
        let html = """
        <h2>Non-English Text with Images</h2>
        
        <p>Korean sentences with <img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> small icons and <img src="https://picsum.photos/id/106/24/24" width="24" height="24" /> larger icons naturally integrated, plus bigger <img src="https://picsum.photos/id/108/32/32" width="32" height="32" /> images aligned to line height.</p>
        
        <p>Mixed language characters: abcdefghijk <img src="https://picsum.photos/id/103/18/18" width="18" height="18" /> lmnopqrstuv 
        wxyzabcdefg <img src="https://picsum.photos/id/104/20/20" width="20" height="20" /> hijklmnopqr 
        stuvwxyzabc <img src="https://picsum.photos/id/105/22/22" width="22" height="22" /> defghijklmn.</p>
        
        <p>Consecutive images with long text: 
        <img src="https://picsum.photos/id/102/16/16" width="16" height="16" /><img src="https://picsum.photos/id/103/18/18" width="18" height="18" /><img src="https://picsum.photos/id/104/20/20" width="20" height="20" />
        Thisishowaverylongtextwithconsecutiveimageswillbehaveinlinebreakingscenarios.</p>
        """
        
        let view = HTMLView(html: html, parser: HTMLFuziParser())
            .htmlEnvironment(\.configuration, .sample)
            .htmlEnvironment(\.styleContainer, .sample(by: .byCharWrapping))
            .frame(width: 350)
            .fixedSize(horizontal: false, vertical: true)

        try? await ViewSnapshotTester.snapshot(
            of: view,
            named: "nonEnglishTextWithImages",
            sleep: .seconds(3)
        )
    }

    @MainActor
    @Test(arguments: [LineBreakMode.byWordWrapping, LineBreakMode.byCharWrapping])
    func testLongWordsWithImages(lineBreakMode: LineBreakMode) async throws {
        let html = """
        <h2>Long Words and Images Test</h2>
        
        <p>Long English words: Supercalifragilisticexpialidocious<img src="https://picsum.photos/id/104/20/20" width="20" height="20" />
        and pneumonoultramicroscopicsilicovolcanoconiosis<img src="https://picsum.photos/id/102/16/16" width="16" height="16" />
        extremelylongwordswithoutspaces<img src="https://picsum.photos/id/103/18/18" width="18" height="18" />includedintextcontent</p>
        
        <p>This is a verylongwordthatwillnotfitinasingleline and
        verylongEnglishwordsthatwillneedtobreakacrosslinesexample with <img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> images included in the middle.</p>
        """
        
        let view = HTMLView(html: html, parser: HTMLFuziParser())
            .htmlEnvironment(\.configuration, .sample)
            .htmlEnvironment(\.styleContainer, .sample(by: lineBreakMode))
            .frame(width: 280)
            .fixedSize(horizontal: false, vertical: true)

        assertSnapshot(of: view, as: .image, named: "longWordsWithImages_\(lineBreakMode)")
    }

    @MainActor
    @Test("Complex Image Layout")
    func testComplexImageLayout() async throws {
        let html = """
        <section>
            <h2>Complex Image Layout Test</h2>
            
            <p>First line: <img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> small image</p>
            <p>Second line: <img src="https://picsum.photos/id/106/24/24" width="24" height="24" /> medium image</p>
            <p>Third line: <img src="https://picsum.photos/id/108/32/32" width="32" height="32" /> large image</p>
            
            <p>Consecutive images: <img src="https://picsum.photos/id/104/20/20" width="20" height="20" /><img src="https://picsum.photos/id/104/20/20" width="20" height="20" /><img src="https://picsum.photos/id/104/20/20" width="20" height="20" /></p>
            
            <p>Text <img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> between <img src="https://picsum.photos/id/106/24/24" width="24" height="24" /> image <img src="https://picsum.photos/id/104/20/20" width="20" height="20" /> placement</p>
            
            <p>Mixed sizes: 
            <img src="https://picsum.photos/id/100/8/8" width="8" height="8" />
            <img src="https://picsum.photos/id/101/12/12" width="12" height="12" />
            <img src="https://picsum.photos/id/102/16/16" width="16" height="16" />
            <img src="https://picsum.photos/id/104/20/20" width="20" height="20" />
            <img src="https://picsum.photos/id/106/24/24" width="24" height="24" />
            <img src="https://picsum.photos/id/107/28/28" width="28" height="28" />
            <img src="https://picsum.photos/id/108/32/32" width="32" height="32" />
            various sized consecutive images</p>
        </section>
        """
        
        let view = HTMLView(html: html, parser: HTMLFuziParser())
            .htmlEnvironment(\.configuration, .sample)
            .htmlEnvironment(\.styleContainer, .sample(by: .byWordWrapping))
            .frame(width: 375)
            .fixedSize(horizontal: false, vertical: true)

        try? await ViewSnapshotTester.snapshot(
            of: view,
            named: "complexImageLayout",
            sleep: .seconds(3)
        )
    }

    @MainActor
    @Test
    func testingWordBrek() async throws {
        let html = """
        <body style="font-family: Arial, sans-serif; margin: 20px;">
            <h1>Word Break Test Examples</h1>
            
            <!-- 일반 케이스 -->
            <div style="width: 200px; margin: 20px 0; padding: 10px; border: 1px solid #ccc; background-color: #f8f8f8;">
                <p style="font-weight: bold; margin-bottom: 5px;">Default/Normal:</p>
                <p>This paragraph contains some normal text with spaces and then a verylongwordthatwillnotfitonasinglelineandwillneedtobreaksomehow to demonstrate line breaking behavior. We also include pneumonoultramicroscopicsilicovolcanoconiosis which is a very long word.</p>
            </div>
            
            <!-- break-all 케이스 -->
            <div style="width: 200px; margin: 20px 0; padding: 10px; border: 1px solid #ccc; background-color: #f8f8f8;">
                <p style="font-weight: bold; margin-bottom: 5px;">word-break: break-all</p>
                <p style="word-break: break-all;">This paragraph contains some normal text with spaces and then a verylongwordthatwillnotfitonasinglelineandwillneedtobreaksomehow to demonstrate line breaking behavior. We also include pneumonoultramicroscopicsilicovolcanoconiosis which is a very long word.</p>
            </div>
            
            <!-- keep-all 케이스 -->
            <div style="width: 200px; margin: 20px 0; padding: 10px; border: 1px solid #ccc; background-color: #f8f8f8;">
                <p style="font-weight: bold; margin-bottom: 5px;">word-break: keep-all</p>
                <p style="word-break: keep-all;">This paragraph contains some normal text with spaces and then a verylongwordthatwillnotfitonasinglelineandwillneedtobreaksomehow to demonstrate line breaking behavior. We also include pneumonoultramicroscopicsilicovolcanoconiosis which is a very long word.</p>
            </div>
            
            <!-- break-word 케이스 -->
            <div style="width: 200px; margin: 20px 0; padding: 10px; border: 1px solid #ccc; background-color: #f8f8f8;">
                <p style="font-weight: bold; margin-bottom: 5px;">word-break: break-word</p>
                <p style="word-break: break-word;">This paragraph contains some normal text with spaces and then a verylongwordthatwillnotfitonasinglelineandwillneedtobreaksomehow to demonstrate line breaking behavior. We also include pneumonoultramicroscopicsilicovolcanoconiosis which is a very long word.</p>
            </div>
            
            <!-- 상속 테스트 -->
            <div style="width: 200px; margin: 20px 0; padding: 10px; border: 1px solid #ccc; background-color: #f8f8f8; word-break: break-all;">
                <p style="font-weight: bold; margin-bottom: 5px;">Parent: break-all</p>
                <p>This text inherits parent break-all setting with a verylongwordthatwillnotfitonasinglelineandwillneedtobreaksomehow. The inheritance should apply automatically.</p>
                <p style="word-break: inherit;">This text explicitly uses word-break: inherit with a verylongwordthatwillnotfitonasinglelineandwillneedtobreaksomehow which should result in the same behavior as the parent.</p>
            </div>
            
            <!-- initial 테스트 -->
            <div style="width: 200px; margin: 20px 0; padding: 10px; border: 1px solid #ccc; background-color: #f8f8f8; word-break: break-all;">
                <p style="font-weight: bold; margin-bottom: 5px;">Parent: break-all, Child: initial</p>
                <p style="word-break: initial;">This text uses word-break: initial with a verylongwordthatwillnotfitonasinglelineandwillneedtobreaksomehow which should ignore the parent's break-all setting and use the default behavior instead.</p>
            </div>
            
            <!-- 다국어 테스트 - 한국어 -->
            <div style="width: 200px; margin: 20px 0; padding: 10px; border: 1px solid #ccc; background-color: #f8f8f8;">
                <p style="font-weight: bold; margin-bottom: 5px;">Korean Text - Default:</p>
                <p>이것은한국어로된매우매우매우매우매우매우매우매우매우매우매우매우매우매우매우매우매우매우매우긴단어입니다 그리고 다음은 약간의 영어 텍스트입니다 with some long words interspersed.</p>
            </div>
            
            <div style="width: 200px; margin: 20px 0; padding: 10px; border: 1px solid #ccc; background-color: #f8f8f8;">
                <p style="font-weight: bold; margin-bottom: 5px;">Korean Text - break-all:</p>
                <p style="word-break: break-all;">이것은한국어로된매우매우매우매우매우매우매우매우매우매우매우매우매우매우매우매우매우매우매우긴단어입니다 그리고 다음은 약간의 영어 텍스트입니다 with some long words interspersed.</p>
            </div>
            
            <div style="width: 200px; margin: 20px 0; padding: 10px; border: 1px solid #ccc; background-color: #f8f8f8;">
                <p style="font-weight: bold; margin-bottom: 5px;">Korean Text - keep-all:</p>
                <p style="word-break: keep-all;">이것은한국어로된매우매우매우매우매우매우매우매우매우매우매우매우매우매우매우매우매우매우매우긴단어입니다 그리고 다음은 약간의 영어 텍스트입니다 with some long words interspersed.</p>
            </div>
            
            <!-- 중국어 테스트 -->
            <div style="width: 200px; margin: 20px 0; padding: 10px; border: 1px solid #ccc; background-color: #f8f8f8;">
                <p style="font-weight: bold; margin-bottom: 5px;">Chinese Text - Default:</p>
                <p>这是一个非常非常非常非常非常非常非常非常非常非常非常非常非常非常非常非常非常长的中文单词示例 mixed with some English text to see how it breaks.</p>
            </div>
            
            <div style="width: 200px; margin: 20px 0; padding: 10px; border: 1px solid #ccc; background-color: #f8f8f8;">
                <p style="font-weight: bold; margin-bottom: 5px;">Chinese Text - break-all:</p>
                <p style="word-break: break-all;">这是一个非常非常非常非常非常非常非常非常非常非常非常非常非常非常非常非常非常长的中文单词示例 mixed with some English text to see how it breaks.</p>
            </div>
            
            <!-- 특수 문자 테스트 -->
            <div style="width: 200px; margin: 20px 0; padding: 10px; border: 1px solid #ccc; background-color: #f8f8f8;">
                <p style="font-weight: bold; margin-bottom: 5px;">URL - Default:</p>
                <p>Please visit https://www.thisisaverylongdomainnamethatwillnotfitonasingleline.com/path/to/resource?param=value&anotherparam=test&evenmoreparam=value for more information.</p>
            </div>
            
            <div style="width: 200px; margin: 20px 0; padding: 10px; border: 1px solid #ccc; background-color: #f8f8f8;">
                <p style="font-weight: bold; margin-bottom: 5px;">URL - break-all:</p>
                <p style="word-break: break-all;">Please visit https://www.thisisaverylongdomainnamethatwillnotfitonasingleline.com/path/to/resource?param=value&anotherparam=test&evenmoreparam=value for more information.</p>
            </div>
            
            <!-- 이메일 테스트 -->
            <div style="width: 200px; margin: 20px 0; padding: 10px; border: 1px solid #ccc; background-color: #f8f8f8;">
                <p style="font-weight: bold; margin-bottom: 5px;">Email - Default:</p>
                <p>Please contact verylongemailaddressthatwillnotfitonasingleline@extremelylongdomainname.com for assistance.</p>
            </div>
            
            <div style="width: 200px; margin: 20px 0; padding: 10px; border: 1px solid #ccc; background-color: #f8f8f8;">
                <p style="font-weight: bold; margin-bottom: 5px;">Email - break-all:</p>
                <p style="word-break: break-all;">Please contact verylongemailaddressthatwillnotfitonasingleline@extremelylongdomainname.com for assistance.</p>
            </div>
        </body>
        """

        let view = HTMLView(html: html, parser: HTMLFuziParser())
            .htmlEnvironment(\.configuration, .sample)
            .htmlEnvironment(\.styleContainer, .sample(by: .byWordWrapping))
            .frame(width: 375)
            .fixedSize(horizontal: true, vertical: false)
        assertSnapshot(of: view, as: .image)
    }
}


extension UIView {
    func pinToTopLeading(of superview: UIView, topInset: CGFloat = 0, leadingInset: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: topInset),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leadingInset)
        ])
    }
}

extension HTMLStyleContainer {
    static func totalInfo() -> HTMLStyleContainer {
        var style = HTMLStyleContainer()
        style.uiFont = .systemFont(ofSize: 14)
        style.textLine = .lineSpacing(spacing: 24)
        return style
    }
}
