require 'securerandom'

class StringToHtml
  @content
  @rules

  def initialize(textContent: '', rules: {})
    @content = textContent
    @rules = rules
  end

  def parseText
    #split text to into an array of separate paragraphs
    plainText = @content.split("\n\n").to_a
    # add html paragraphing
    paragraphedText = plainText.map { |i| "<p>"+i+"</p><br>"}
    #add highlighting
    paragraphedTextasArray = paragraphedText.join('').split(" ").to_a
    highlightedText = checkAgainstRules(paragraphedTextasArray)
  end

  def checkAgainstRules(textArray)
    #copy of array to be modified
    modifiedTextArray = textArray
    #for each rule, find corresponding item in array and apply styles formating with random hexcolor generator function
    @rules.each do |n|
      #-1 to account for 0 based counting done when using arrays
      @start   =  n[:start] - 1
      @ends    =  n[:end] - 1
      @comment =  n[:comment]
      modifiedTextArray[@start] = "<div class='tooltip' style='background:#{genHex};'>"+textArray[@start]
      modifiedTextArray[@ends] = textArray[@ends]+"<div class='tooltiptext'>#{@comment}</div></div>"
    end
    finalText = modifiedTextArray.join(" ")
  end

  def genHex
    # SecureRandom.hex(3) no opacity hence won't show up properly on overlap
    randomColor = 'rgba('+"#{rand(0...255)},#{rand(0...255)},#{rand(0...255)},0.#{rand(5...9)}"+')'
    randomColor
  end



end

String content = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas consectetur malesuada velit, sit amet porta magna maximus nec. Aliquam aliquet tincidunt enim vel rutrum. Ut augue lorem, rutrum et turpis in, molestie mollis nisi. Ut dapibus erat eget felis pulvinar, ac vestibulum augue bibendum. Quisque sagittis magna nisi. Sed aliquam porttitor fermentum. Nulla consequat justo eu nulla sollicitudin auctor. Sed porta enim non diam mollis, a ullamcorper dolor molestie. Nam eu ex non nisl viverra hendrerit. Donec ante augue, eleifend vel eleifend quis, laoreet volutpat ipsum. Integer viverra aliquam nulla, ac rutrum dui sodales nec.

Sed turpis enim, porttitor nec maximus sed, luctus pretium elit. Sed sodales imperdiet velit, vitae viverra erat commodo non. Nunc porttitor risus sit amet quam faucibus, et luctus ex fringilla. Mauris quis urna non lacus tempor iaculis vitae quis dolor. Nam vitae pulvinar lacus, quis varius erat. Etiam lobortis orci vitae elementum tempor. Praesent convallis euismod enim vel vestibulum. Proin vitae eros vitae nisi cursus dapibus vitae at ipsum. Phasellus sed tempor eros, non scelenimerisque nunc. Nullam condimentum ex ultrices, ultrices ante sit amet, rhoncus nibh. Aliquam fermentum vulputate fringilla. Ut risus orci, pharetra eu tellus vel, fringilla feugiat dolor.

Nunc quis elit quam. Sed aliquet, nibh ut sagittis egestas, lorem tortor laoreet diam, non maximus lectus dolor dignissim eros. Sed vehicula mi id aliquet aliquam. Vestibulum sed lacus et neque dictum convallis in vitae mauris. Etiam varius augue vel mattis tempor. Curabitur mattis facilisis metus, tempus consectetur quam aliquam sed. Mauris velit orci, efficitur sit amet nisl in, finibus dictum elit. In lectus augue, elementum eu sapien sed, auctor tincidunt urna.

Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Integer lacinia accumsan velit. Duis vel facilisis libero. Cras consequat sit amet mauris ut ultrices. Ut pulvinar sit amet odio sit amet pretium. Nullam tortor ligula, consequat non nisl vitae, rutrum placerat est. Sed finibus interdum justo vel placerat. Cras varius tortor sed justo tempus scelerisque. Praesent facilisis ex vitae iaculis iaculis. Sed consectetur a lectus non condimentum. Etiam id lacus a nulla cursus laoreet. Vivamus ipsum purus, sodales vel metus varius, viverra mollis justo. Nulla facilisi. Vivamus volutpat nunc elit, quis sollicitudin velit ornare sit amet.

Nullam fringilla nisi nunc, vitae accumsan tortor luctus quis. Sed facilisis, est ut eleifend sagittis, felis dolor pellentesque lectus, in congue purus orci non nunc. Nunc finibus eu metus et volutpat. Integer hendrerit tortor et tellus euismod vulputate. Aliquam erat volutpat. Aenean gravida justo in risus feugiat, ut suscipit tortor ullamcorper. Nam a sapien dictum, vestibulum eros vitae, sodales turpis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed ultricies at elit et rutrum. Sed placerat erat quis condimentum convallis. Duis ornare magna nec ante faucibus malesuada. Duis a erat sed sapien semper eleifend. Mauris consequat nibh sollicitudin mi euismod, non ultricies lectus bibendum. Cras a erat libero. Aliquam nisl ipsum, scelerisque at risus a, hendrerit vestibulum sapien. Proin luctus diam eu mi lobortis molestie id vel ante."

highlights = [{
                  start: 20,
                  end: 35,
                  comment: 'Foo'
              }, {
                  start: 73,
                  end: 92,
                  comment: 'Bar'
              }, {
                  start: 50,
                  end: 98,
                  comment: 'Baz'
              }]

runit = StringToHtml.new(textContent: content, rules: highlights)
runit.parseText()


#TODO code test link https://gist.github.com/autonomous/56630836b491734211c440f16bcb53a9
#TODO submit by Thursday or Friday, and ask questions
#TODO create git repo, and add each function as a git commit, and then add unit tests using minitest