package Bric::Util::Language::zh_tw;

=head1 NAME

Bric::Util::Language::zh_tw - Bricolage 正體中文翻譯

=head1 VERSION

$Revision: 1.16 $

=cut

our $VERSION = (qw$Revision: 1.16 $ )[-1];

=head1 DATE

$Date: 2004/03/24 20:44:19 $

=head1 SYNOPSIS

In F<bricolage.conf>:

  LANGUAGE = zh_tw

=head1 DESCRIPTION

Bricolage 正體中文翻譯.

=cut

use constant key => 'zh_tw';

our @ISA = qw(Bric::Util::Language);

our %Lexicon =
   (
    ' contains illegal characters!' => ' 內有非法字元 !',
    '"[_1]" Elements saved.' => '[_1] 元素已被儲存。',
    '404 NOT FOUND' => '404 網頁找不到',
    'A template already exists for the selected output channel, category, element and burner you selected.  You must delete the existing template before you can add a new one.' => '所選之輸出頻道、分類、元素、與burner已有對應之起用的模板，在增加新的模板之前，你必須先刪除目前存在的模板。',
    'ADMIN' => '管理',
    'ADVANCED SEARCH' => '進階搜尋',
    'Action profile "[_1]" deleted.' => '行動設定「[_1]」已刪除',
    'Action profile "[_1]" saved.' => '行動設定「[_1]」已儲存',
    'Actions' => '行動',
    'Active Media' => '編修中的媒體',
    'Active Stories' => '編修中的稿件',
    'Active Templates' => '編修中的模板',
    'Active' => '起用',
    'Add New Field' => '增加一個新欄位',
    'Add a New Alert Type' => '增加新的警告型別',
    'Add a New Category' => '增加一個新的分類',
    'Add a New Contributor Type' => '增加新的供稿者型別',
    'Add a New Desk' => '增加一個新桌面',
    'Add a New Destination' => '增加新的目標',
    'Add a New Element Type' => '增加一個新的元素型別',
    'Add a New Element' => '增加新的元素',
    'Add a New Group' => '增加新的群組',
    'Add a New Media Type' => '增加一個新的媒體型別',
    'Add a New Output Channel' => '增加一個新的輸出頻道',
    'Add a New Source' => '增加新的來源',
    'Add a New User' => '增加新的使用者',
    'Add a New Workflow' => '增加新的流程',
    'Add to Element' => '加入到元素',
    'Add to Include' => '將這些包含在內',
    'Add' => '增加',
    'Admin' => '管理',
    'Advanced Search' => '進階搜尋',
    'Alert Type Manager' => '警告型別管理',
    'Alert Type profile "[_1]" deleted.' => '警告型別設定「[_1]」已刪除',
    'Alert Type profile "[_1]" saved.' => '警告型別設定「[_1]」已儲存',
    'Alert Types' => '警告型別',
    'All Contributors' => '所有的供稿者',
    'All Elements' => '所有的元素',
    'All Groups' => '所有的群組',
    'Allow multiple' => '允許多選',
    'An [_1] attribute already exists. Please try another name.' => '[_1] 屬性已然存在，請用別的名稱。',
    'An error occurred while processing your request:' => '在處理您的要求時，發生了一個錯誤；',
    'An error occurred.' => '錯誤突然出現。',
    'Apr' => '四月',
    'At least one extension is required.' => '至少需要一個延伸.',
    'Attributes' => '屬性',
    'Aug' => '八月',
    'Available Groups' => '可用的群組',
    'Available Output Channels' => '可用的輸出頻道',
    'Bad element name "[_1]". Did you mean "[_2]"?' => '元素名稱錯誤：「[_1]」。也許您是指「[_2]」？',
    'By Last' => '依照最後',
    'By Source name' => '按照來源名稱',
    'CONTACTS' => '聯絡人',
    'Cannot auto-publish related media "[_1]" because it is checked out.' => '無法自動出版相關的媒體 [_1] ，因為它尚未送回',
    'Cannot auto-publish related story "[_1]" because it is checked out.' => '因其仍被他人取出，所以無法自動出版以下此篇相關的故事：「[_1]」',
    'Cannot both delete and make primary a single output channel.' => '你不能夠對輸出頻道同時進行刪除與「設為主要」的動作',
    'Cannot cancel "[_1]" because it is currently executing.' => '不能取消 [_1] ，因為它目前正在執行中。',
    'Cannot create an alias to a media in the same site.' => '在同站之中無法建立媒體的別名',
    'Cannot create an alias to a story in the same site.' => '在同站之中無法建立故事的別名',
    'Cannot move [_1] asset "[_2]" while it is checked out' => '不能將 [_1] 資產移動到 \'[_2]\' ，因為目前已被取出',
    'Cannot preview asset "[_1]" because there are no Preview Destinations associated with its output channels.' => '無法預覽此資產：「[_1]」。其輸出頻道沒有對應到任何預覽用的發佈目標。',
    'Cannot publish asset "[_1]" to "[_2]" because there are no Destinations associated with this output channel.' => '無法將資產「[_1]]」發佈到「[_2]]」，因為此輸出頻道沒有設定散佈目標。',
    'Cannot publish checked-out media "[_1]"' => '尚未送回的媒體 [_1] 不能被出版',
    'Cannot publish checked-out story "[_1]"' => '未送回的稿子 [_1] 不能出版',
    'Cannot publish media "[_1]" because it is checked out.' => '因其仍被他人取出，所以無法出版以下媒體：「[_1]」',
    'Cannot publish story "[_1]" because it is checked out.' => '因其仍被他人取出，所以無法出版以下故事：「[_1]」',
    'Caption' => '標題',
    'Categories' => '分類',
    'Category "[_1]" added.' => '分類 [_1] 已加入.',
    'Category "[_1]" cannot be deleted.' => '分類 [_1] 不能被刪除。',
    'Category "[_1]" disassociated.' => '以斷絕「[_1]」這個分類的關係',
    'Category Assets' => '分類資產',
    'Category Manager' => '分類管理',
    'Category Permissions' => '分類權限',
    'Category URI' => '分類URI',
    'Category profile "[_1]" and all its categories deleted.' => '分類設定 [1] 與其所有分類皆已刪除。',
    'Category profile "[_1]" deleted.' => '分類設定 [_1] 已刪除。',
    'Category profile "[_1]" saved.' => '分類設定 [_1] 已儲存。',
    'Category tree' => '分類樹',
    'Category' => '分類',
    'Changes not saved: permission denied.' => '無法儲存：權限遭拒',
    'Characters' => '字元',
    'Check In Assets' => '送回資產',
    'Check In To' =>'送回至',
    'Check In to Edit' => '送回給編輯',
    'Check In to Publish' => '送回至 Publish',
    'Check In to [_1]' => '送回到 [_1]',
    'Check In to' => '送回到',
    'Check In' => '送回',
    'Check Out' => '取出',
    'Choose Contributors' => '選取供稿者',
    'Choose Related Media' => '選擇相關的媒體',
    'Choose Subelements' => '選擇子元素',
    'Choose a Related Story' => '選擇相關的稿件',
    'Clone'  => '複製',
    'Columns' => '欄',
    'Contacts' => '聯絡人',
    'Content Type' => 'Content Type',
    'Content' => '內容',
    'Contributor "[_1]" disassociated.' => '已斷絕供稿者 [_1] 的關係。',
    'Contributor Roles' => '供稿者角色',
    'Contributor Type Manager' => '供稿者型別管理',
    'Contributor Types' => '供稿者型別',
    'Contributor profile "[_1]" deleted.' => '供稿者設定 [_1] 已刪除。',
    'Contributor profile "[_1]" saved.' => '供稿者設定 [_1] 已儲存。',
    'Contributors disassociated.' => '已斷絕供稿者的關係',
    'Contributors' => '供稿者',
    'Cover Date incomplete.' => '見報日期不完整。',
    'Cover Date' => '見報日期',
    'Create a New Category' => '建立新的分類',
    'Create a New Media' => '建立一個新的媒體',
    'Create a New Story' => '增加一份新的稿件',
    'Create a New Template' => '建立新模板',
    'Current Groups' => '目前的群組',
    'Current Note' => '目前的注意事項',
    'Current Output Channels' => '目前採用的輸出頻道',
    'Current Version' => '目前版本',
    'Currently Related Story' => '目前相關的稿件',
    'Custom Fields' => '自訂欄位',
    'DISTRIBUTION' => '散佈',
    'Data Elements' => '資料元素',
    'Day' => '日',
    'Dec' => '十二月',
    'Default Value' => '預設值',
    'Delete this Category and All its Subcategories' => '刪除這個分類以及其所有子分類',
    'Delete this Desk from all Workflows' => '自所有流程中刪除此桌面',
    'Delete this Element' => '刪除這個元素',
    'Delete this Profile' => '刪除這個設定',
    'Delete' => '刪除',
    'Deploy' => '佈署',
    'Deployed Date' => '佈署的日期',
    'Description' => '描述',
    'Desk Permissions' => '桌面權限',
    'Desk profile "[_1]" deleted from all workflows.' => '桌面設定 [_1] 已從所有的流程中刪除。',
    'Desk'   => '桌面',
    'Desks'   => '桌面',
    'Destination Manager' => '發佈目標管理',
    'Destination not specified' => '尚未指定發佈目標',
    'Destination profile "[_1]" deleted.' => '發佈目標 [_1] 已刪除。',
    'Destination profile "[_1]" saved.' => '發佈目標 [_1] 已儲存。',
    'Destinations' => '發佈目標',
    'Development' => '發展',
    'Directory name "[_1]" contains invalid characters. Please try a different directory name.' => '目錄名稱[_1]還有非法的字元，請調整目錄名稱。',
    'Distributing files.' => '檔案散佈中',
    'Download' => '下載',
    'EXISTING CATEGORIES' => '已有的分類',
    'EXISTING DESTINATIONS' => '已有的目標',
    'EXISTING ELEMENT TYPES' => '已有的元素型別',
    'EXISTING ELEMENTS' => '已有的元素',
    'EXISTING MEDIA TYPES' => '已有的媒體型別',
    'EXISTING OUTPUT CHANNELS' => '<b>已有的輸出頻道</b>',
    'EXISTING SOURCES' => '已有的來源',
    'EXISTING USERS' => '已有的使用者',
    'Edit' => '編輯',
    'Element "[_1]" deleted.' => '元素 [_1] 已刪除。',
    'Element "[_1]" saved.' => '元素[_1]已儲存',
    'Element Manager' => '元素管理',
    'Element Type Manager' => '元素類別管理',
    'Element Type profile "[_1]" deleted.' => '元素型別設定 [_1] 已刪除。',
    'Element Type profile "[_1]" saved.' => '元素型別設定 [_1] 已儲存。',
    'Element Types' => '元素型別',
    'Element must be associated with at least one site and one output channel.' => '任何元素都必須關聯到至少一個站，與輸出頻道。',
    'Element' => '元素',
    'Elements' => '元素',
    'Error' => '錯誤',
    'Event Type' => '事件型別',
    'Events' => '事件',
    'Existing Notes' => '目前的注意事項',
    'Existing Subelements' => '已有的子元素',
    'Existing roles' => '已有的角色',
    'Expire Date incomplete.' => '到期日不完整。',
    'Expire Date' => '到期日',
    'Expire' => '到期',
    'Extension "[_1]" ignored.' => '副檔名 [_1] 已被忽略',
    'Extension "[_1]" is already used by media type "[_2]".' => '副檔名 [_1] 已被其他媒體型別所用',
    'Extension' => '副檔名',
    'Extensions' => '副檔名',
    'Feb' => '二月',
    'Field "[_1]" appears more than once but it is not a repeatable element.  Please remove all but one.' => '「[_1]」欄位出現了一次以上，不過它並非可重複的元素，因此請移除多餘的部份。',
    'Fields' => '欄',
    'File Name' => '檔案名稱',
    'File Path' => '檔案路徑',
    'Find Media' => '搜尋媒體',
    'Find Stories' => '搜尋稿件',
    'Find Templates' => '搜尋模板',
    'First Name' => '名',
    'First Published' => => '第一個發佈的',
    'First' => '第一',
    'Fixed' => '固定的',
    'Generic' => '通用的',
    'Grant "[_1]" members permission to access assets in these categories.' => '允許 [_1] 成員權限得以存取這些分類裡面的資產。',
    'Grant "[_1]" members permission to access assets in these workflows.' => '允許 [_1] 成員權限能夠存取這些流程裡面的資產。',
    'Grant "[_1]" members permission to access assets on these desks.' => '允許 [_1] 成員權限得以存取這些桌面的資產。',
    'Grant "[_1]" members permission to access the members of these groups.' => '允許 [_1] 成員之權限得以存取這些群組裡面之成員',
    'Grant the members of the following groups permission to access the members of the "[_1]" group.' => '允許以下群組的成員得以存取 [_1] 群組的成員。',
    'Group Label' => '群組標記',
    'Group Manager' => '群組管理',
    'Group Memberships' => '群組成員',
    'Group Type' => '群組型別',
    'Group cannot be deleted' => '不能刪除群組',
    'Group profile "[_1]" deleted.' => '群組設定 [_1] 已刪除。',
    'Group profile "[_1]" saved.' => '群組設定 [_1] 以儲存',
    'Groups' => '群組',
    'High'=> '最高',
    'Hour' => '時',
    'ID' => 'ID',
    'Invalid date value for "[_1]" field.' => '日期欄位「[_1]」的值無效',
    'Invalid page request' => '無效的頁面要求',
    'Invalid password. Please try again.' => '密碼無校，請再試一次',
    'Invalid username or password. Please try again.' => '使用者名稱或者密碼無效，請再試一次。',
    'Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec' => '一月 二月 三月 四月 五月 六月 七月 八月 九月 十月 十一月 十二月',
    'Jan' => '一月',
    'Job Manager' => '工作管理',
    'Job profile "[_1]" deleted.' => '工作設定 [_1] 已刪除。',
    'Job profile "[_1]" saved.' => '工作設定 [_1] 已儲存。',
    'Jobs' => '工作',
    'Jul' => '七月',
    'Jun' => '六月',
    'Keywords saved.' => '關鍵字已儲存。',
    'Label' => '標記',
    'Last Name' => '姓',
    'Last' => '最後',
    'Log' => '紀錄',
    'Login "[_1]" contains invalid characters.' => '登入帳號 [_1] 內含非法字元啊！',
    'Login "[_1]" is already in use. Please try again.' => '登入 [_1] 已被使用，請再試一次。',
    'Login ' => '登入',
    'Login and Password' => '登入及密碼',
    'Login cannot be blank. Please enter a login.' => '登入欄位不能留白，請務必正確輸入',
    'Login must be at least [_1] characters.' => '登入帳號至少要有 [_1] 個字元',
    'Login' => '登入帳號',
    'Low'     => '最低',
    'MEDIA FOUND' => '找到媒體',
    'MEDIA' => '媒體 ',
    'Manage' => '管理',
    'Manager' => '管理員',
    'Mar' => '三月',
    'Maximum size' => '最大',
    'May' => '五月',
    'Media "[_1]" check out canceled.' => '已取消取出媒體 [_1] 。',
    'Media "[_1]" created and saved.' => '媒體 [_1] 已建立，並且儲存。',
    'Media "[_1]" deleted.' => '媒體 [_1] 已刪除。',
    'Media "[_1]" published.' => 'Media [_1] 已正式公開出版。',
    'Media "[_1]" reverted to V.[_2]' => '媒體 [_1] 已回復到第 [_2] 版',
    'Media "[_1]" saved and checked in to "[_2]".' => '媒體 [_1] 已儲存，並送回到 [_2].',
    'Media "[_1]" saved and moved to "[_2]".' => '媒體 [_1] 已儲存，並且移動到 [_2]。',
    'Media "[_1]" saved and moved to "[_2]".' => '媒體 [_1] 以儲存，且移動至 [_2]。',
    'Media "[_1]" saved and shelved.' => '媒體 [_1] 已儲存且上架了。',
    'Media "[_1]" saved.' => '媒體 [_1] 已儲存。',
    'Media Type Manager' => '媒體型別管理',
    'Media Type profile "[_1]" deleted.' => '媒體型別設定 [_1] 已經儲存。',
    'Media Type profile "[_1]" saved.' => '媒體型別 [_1] 已儲存。',
    'Media Type' => '媒體型別',
    'Media Type Element' => '媒體型別',
    'Media Types' => '媒體型別',
    'Medium High' => '較高',
    'Medium Low' => '較低 ',
    'Member Type  ' => '成員型別',
    'Members' => '成員',
    'Minute' => '分',
    'Month' => '月',
    'Move Assets' => '移動資產',
    'Move to Desk' => '移到桌面',
    'Move to' => '移到',
    'My Alerts' => '我的警告',
    'My Workspace' => '我的工作區',
    'NAME' => '名稱',
    'Name is required.' => '名稱為必要的。',
    'Name' => '名稱',
    'New Media' => '新增媒體',
    'New Role Name' => '新角色名稱',
    'New Story' => '新增稿件',
    'New Template' => '新增樣板',
    'New password' => '新密碼',
    'New passwords do not match. Please try again.' => '新密碼不符，請再輸入一次',
    'New' => '新的',
    'No alert types were found' => '找不到警告型別',
    'No categories were found' => '找不到分類',
    'No contributor types were found' => '找不到供稿者型別',
    'No contributors defined' => '未有定義好的供稿者',
    'No contributors defined.' => '未定義任何供稿者',
    'No destinations were found' => '找不到目標',
    'No element types were found' => '找不到元素型別設定',
    'No elements are present.' => '找不到元素',
    'No elements have been added.' => '沒有加入任何元素。',
    'No elements were found' => '找不到元素',
    'No existing notes.' => '並無注意事項',
    'No file associated with media "[_1]". Skipping.' => '「[_1]」媒體並無相關的檔案，在此略過。',
    'No file has been uploaded' => '沒有任何以上傳的檔案。',
    'No groups were found' => '找不到群組',
    'No jobs were found' => '找不到工作',
    'No keywords defined.' => '未定義任何關鍵字',
    'No media file is associated with asset "[_1]", so none will be distributed.' => '由於 [_1] 資產完全沒有相關的媒體檔案，所以並不會將檔案散佈出去。',
    'No media types were found' => '找不到媒體型別',
    'No media were found' => '找不到媒體',
    'No output channels were found' => '並沒有找到任何輸出頻道',
    'No output to preview.' => '無預覽輸出',
    'No related Stories' => '無相關的稿件',
    'No sources were found' => '找不到來源',
    'No stories were found' => '找不到任何稿件',
    'No templates were found' => '找不到樣板',
    'No users were found' => '找不到使用者',
    'No workflows were found' => '找不到流程',
    'No' => '否',
    'Normal'  => '正常',
    'Note saved.' => '注意事項已儲存.',
    'Note' => '注意事項',
    'Note: Container element "[_1]" removed in bulk edit but will not be deleted.' => '注意：容器元素「[_1]」在大量編輯模式中被去掉了，但它並不會被刪除。',
    'Note: Data element "[_1]" is required and cannot be completely removed.  Will delete all but one.' => '注意：資料元素「[_1]」為必要的，因此不能全部被移除，將會留下其中一個。',
    'Notes'  => '注意事項',
    'Nov' => '十一月',
    'Object Group Permissions' => '物件群組權限',
    'Oct' => '十月',
    'Old password' => '舊密碼',
    'Options, Label' => '選項、標記',
    'Or Pick a Type' => '或選擇一個型別',
    'Order' => '順序',
    'Organization' => '組織',
    'Output Channel profile "[_1]" deleted.' => '輸出頻道設定 [_1] 已刪除。',
    'Output Channel profile "[_1]" saved.' => '輸出頻道 [_1] 已被儲存。',
    'Output Channel' => '輸出頻道',
    'Output Channels' => '輸出頻道',
    'Owner' => '所有人',
    'PENDING JOBS' => '待辦工作',
    'PLEASE LOG IN' => '請登入',
    'PREFERENCES' => '偏好設定',
    'PROPERTIES' => '特性',
    'PROPERTIES' => '特性',
    'PUBLISHING' => '出版',
    'Page' => '頁',
    'Paragraph' => '段',
    'Parent cannot choose itself or its child as its parent. Try a different parent.' => '一個節點不能把自己或其子節點設定為自己的母節點，請選擇別的節點。',
    'Password contains illegal preceding or trailing spaces. Please try again.' => '密碼前後有非法的空白字元，請再試一次。',
    'Password'  => '密碼',
    'Passwords cannot have spaces at the beginning!' => '密碼開頭不能是空白字元啊！',
    'Passwords cannot have spaces at the end!' => '密碼最後不能有空白字元啊！',
    'Passwords do not match!  Please re-enter.' => '密碼不匹配！請重新輸入。',
    'Passwords must be at least [_1] characters!' => '密碼至少要有 [_1] 個字元！',
    'Passwords must match!' => '密碼一定要匹配',
    'Pending ' => '待辦',
    'Permission Denied' => '權限慘遭拒絕',
    'Permission to checkout "[_1]" denied.' => '取出 [_1] 的權限慘遭拒絕',
    'Permission to delete "[_1]" denied.' => '刪除 [_1] 權限慘遭拒絕',
    'Permissions saved.' => '權限已儲存',
    'Please check the URL and try again. If you feel you have reached this page as a result of a server error or other bug, please notify the server administrator. Be sure to include as much detail as possible, including the type of browser, operating system, and the steps leading up to your arrival here.' => '請仔細檢查URL並且再試一次。如果你覺得你是因為某種伺服器產生的錯誤而來到這個頁面，請儘速通知管理員，並請附上盡量詳細的資訊，包括使用的瀏覽器、作業系統、以及達到這一頁的每個步驟。',
    'Please select a primary category.' => '請選擇一個主要的分類',
    'Please select a story type.' => '請選擇一個稿件型別',
    'Position' => '位置',
    'Post' => 'Post', # XXX: Chinese name scheme don't have this 2 field.
    'Pre' => 'Pre',
    'Preference "[_1]" updated.' => '偏好設定 [_1] 已更新。',
    'Preference Manager' => '偏好設定管理',
    'Preferences' => '偏好設定',
    'Prefix' => 'Prefix',
    'Preview in' => '預覽',
    'Previews' => '預覽',
    'Primary Category' => '主要的分類',
    'Primary Output Channel' => '主要的輸出頻道',
    'Priority' => '優先權',
    'Problem adding "[_1]"' => '增加 [_1] 時發生問題',
    'Problem deleting "[_1]"' => '刪除 [_1] 時發生問題。',
    'Profile' => '設定',
    'Properties' => '特性',
    'Publish Date' => '出版日期',
    'Publish Desk' => '出版桌面',
    'Publish' => '出版',
    'Published Version' => '出版的版本',
    'Publishes' => '出版品',
    'Recipients' => '收件者',
    'Redirecting to preview.' => '重導到御覽',
    'Relate' => '加入關係',
    'Related Media' => '相關的媒體',
    'Related Story' => '相關的稿件',
    'Repeat new password' => '新密碼確認',
    'Repeatable' => '可重複的',
    'Required' => '必要的',
    'Resources' => '資源',
    'Role' => '角色',
    'Roles' => '角色',
    'Rows' => '列',
    'SEARCH' => '尋找',
    'STORIES FOUND' => '找到的稿件',
    'STORIES' => '稿件',
    'STORY INFORMATION' => '稿件資訊',
    'STORY' => '稿件',
    'SUBMIT' => '送出',
    'SYSTEM' => '系統',
    'Scheduled Time' => '排定的時間',
    'Scheduler' => 'Scheduler',
    'Select Desk' => '選一個桌面',
    'Select Role' => '選擇角色',
    'Select an Event Type' => '選擇一個事件型別',
    'Select' => '選擇',
    'Sep' => '九月',
    'Separator Changed.' => '分隔字元已更動。',
    'Separator String' => '分隔字串',
    'Server profile "[_1]" deleted.' => '伺服器設定 [_1] 已經儲存。',
    'Server profile "[_1]" saved.' => '伺服器設定 [_1] 已儲存。',
    'Simple Search' => '簡易搜尋',
    'Site profile "[_1]" deleted.' => '站台設定「[_1]」已刪除',
    'Site profile "[_1]" saved.' => '站台設定「[_1]」已儲存',
    'Size' => '大小',
    'Slug must conform to URI character rules.' => 'Slug 也一定要依循 URI 字元的規則',
    'Slug required for non-fixed (non-cover) story type.' => 'Slug 欄位，在非固定的（非封面）故事型別之中是必要的',
    'Sort By' => '排序方式',
    'Source Manager' => '來源管理',
    'Source name' => '來源名稱',
    'Source profile "[_1]" deleted.' => '來源設定 [_1] 已刪除。',
    'Source profile "[_1]" saved.' => '來源設定 [_1] 已儲存。',
    'Source' => '來源',
    'Sources' => '來源',
    'Start Desk' => '開始桌面',
    'Statistics' => '統計',
    'Status' => '狀態',
    'Stories in this category' => '這個分類裡面的稿件',
    'Story "[_1]" check out canceled.' => '取消取出稿件 [_1]。',
    'Story "[_1]" created and saved.' => '稿件 [_1] 已建立，並且儲存。',
    'Story "[_1]" deleted.' => '稿件 [_1] 已刪除。',
    'Story "[_1]" published.' => '稿件 [_1] 已出版。',
    'Story "[_1]" reverted to V.[_2].' => '稿件 [_1] 已回復到第 [_2] 版。',
    'Story "[_1]" saved and checked in to "[_2]".' => '稿件 [_1] 已經儲存且送回至 [_2]。',
    'Story "[_1]" saved and checked in to "[_2]".' => '稿件 [_1] 已儲存，送回至 [_1] 。',
    'Story "[_1]" saved and moved to "[_2]".' => '稿件 [_1] 已儲存，移動至 [_2] 。',
    'Story "[_1]" saved and shelved.' => '稿件 [_1] 已儲存且上架了。',
    'Story "[_1]" saved.' => '稿件 [_1] 已儲存。',
    'Story Type' => '稿件型別',
    'Story Type Element' => '稿件型別',
    'Subelements' => '子元素',
    'Switch Roles' => '變換角色',
    'TEMPLATE' => '樣板',
    'TEMPLATES FOUND' => '找到的模板',
    'Teaser' => '懸疑廣告',
    'Template "[_1]" check out canceled.' => '取消取出樣板 [_1]。',
    'Template "[_1]" deleted.' => '模板 [_1] 已刪除。',
    'Template "[_1]" saved and moved to "[_2]".' => '模板 [_1] 已建立，並且移動至 [_2]',
    'Template "[_1]" saved and shelved.' => '模板 [_1] 已建立，並且上架了',
    'Template "[_1]" saved.' => '模板 [_1] 已儲存。',
    'Template Includes' => '模板包括了...',
    'Template Name' => '模板名稱',
    'Template compile failed: [_1]' => '模板編譯失敗: [_1]',
    'Template deployed.' => '模板已經配備完成',
    'Text Area' => '文字區域',
    'Text box' => '文字方塊',
    'The URI of this media conflicts with that of [_1].  Please change the category, file name, or slug.' => '此媒體的 URI 與 [_1] 的 URI 相同，請調整分類、檔案名稱、或者 slug。',
    'The URL you requested, <b>[_1]</b>, was not found on this server' => '在這台伺服器上，並沒有找到所求之 URL <b>[_1]</b> ',
    'The category was not added, as it would have caused a URI clash with story [_1].' => '分類並沒有加入，因為會造成與稿件「[_1]」相同的URI。',
    'The cover date has been reverted to [_1], as it caused this story to have a URI conflicting with that of story \'[_2].' => '見報日期已經回復到 [_1] ，因為原本這篇稿子的 URI 與 \'[_2]\' 這篇稿子相同。 ',
    'The key name "[_1]" is already used by another ???.' => '鍵值名稱「_1」似乎已經被使用了。',
    'The name "[_1]" is already used by another Alert Type.' => '「[_1]」這個名稱已經被其他的警告型別使用了',
    'The name "[_1]" is already used by another Desk.' => '「[_1]」這個名稱已經被其他的桌面使用了',
    'The name "[_1]" is already used by another Destination.' => '「[_1]」這個名稱已經被其他的發佈目標使用了',
    'The name "[_1]" is already used by another Element Type.' => '[_1] 這名稱已經被其他的元素型別使用。',
    'The name "[_1]" is already used by another Media Type.' => '[_1] 這個名稱已被其他的媒體型別佔用。',
    'The name "[_1]" is already used by another Output Channel.' => '[_1] 這個名字已經被其他的輸出頻道使用了',
    'The name "[_1]" is already used by another Source.' => '[_1] 這個名稱已經被其他的來源採用',
    'The name "[_1]" is already used by another Workflow.' => '其他流程已經使用了 [_1] 這個名字',
    'The slug can only contain alphanumeric characters (A-Z, 0-9, - or _)!' => 'Slug 裡面只能用英文字母、阿拉伯數字、短線、與底線字元！',
    'The slug has been reverted to [_1], as the slug [_2] caused this story to have a URI conflicting with that of story [_3].' => '此 Slug 已被回復到 [_1]，因為 Slug [_2] 使得這篇稿件的 URI 與「[_3]」這篇稿件的 URI 相同。',
    'The slug, category and cover date you selected would have caused this story to have a URI conflicting with that of story [_1].' => '這篇稿件所選的的 slug、分類、以及見報日期，將使其 URI 與「[_1]」這篇稿件相同',
    'This day does not exist! Your day is changed to the' => '這一天根本不存在啊！它已經被改為',
    'This story has not been assigned to a category.' => '這份稿件目前尚未被分類',
    'Timestamp'   => '時間',
    'Title' => '標題',
    'Trail'  => '更改紀錄',
    'Triggered By' => '觸發者',
    'Type' => '型別',
    'URI "[_1]" is already in use. Please try a different directory name or parent category.' => 'URI [_1] 已被使用，請調整目錄名稱或者是分類。',
    'URI' => 'URI',
    'URL' => 'URL',
    'Un-relate' => '解除關係',
    'User Manager' => '使用者管理',
    'User Override' => '變身為別的使用者',
    'User profile "[_1]" deleted.' => '使用者設定 [_1] 已刪除。',
    'User profile "[_1]" saved.' => '使用者設定「[_1]」已儲存',
    'Username' => '使用者名稱',
    'Usernames must be at least 6 characters!' => '使用者名稱至少需要六個字元',
    'Users' => '使用者',
    'Using Cyclops without JavaScript can result in corrupt data and system instability. Please activate JavaScript in your browser before continuing.' => '在未啟用 JavaScript 時使用 Cyclops 可能會導致資料損毀、系統不穩定等狀況，請立刻啟動瀏覽器的JavaScript。',
    'Value Name' => '值',
    'View' => '看看',
    'Warning! Cyclops is designed to run with JavaScript enabled.' => '警告！執行Cyclops必須同時啟動JavaScript才行！',
    'Warning! State inconsistent: Please use the buttons provided by the application rather than the \'Back\'/\'Forward\' buttons.' => '警告！狀態產生矛盾：請務必利用本程式所給的按鈕，不要用瀏覽器的「向前」「向後」按鈕。',
    'Warning:  Use of element\'s \'name\' field is deprecated for use with element method \'get_container\'.  Please use the element\'s \'key_name\' field instead.' => '警告：以元素的 get_container 方法取得 \'name\' 欄位的用法已經過時了，請改用元素的 \'key_name\' 欄位。',
    'Warning:  Use of element\'s \'name\' field is deprecated for use with element method \'get_data\'.  Please use the element\'s \'key_name\' field instead.' => '警告：以元素的 get_data 方法取得 \'name\' 欄位的用法已經過時了，請改用元素的 \'key_name\' 欄位。',
    'Warning: object "[_1]" had no associated desk.  It has been assigned to the "[_2]" desk.' => '警告：[_1] 沒有所屬的桌面，它已經被移動到 [_2] 這個桌面。',
    'Warning: object "[_1]" had no associated workflow.  It has been assigned to the "[_2]" workflow. This change also required that this object be moved to the "[_3]" desk.' => '警告：「[_1]」物件並不屬於任何流程，所以已經被放入「[_2]」流程中。此項異動同時已把物件移到「[_3]」桌面。',
    'Warning: object "[_1]" had no associated workflow.  It has been assigned to the "[_2]" workflow.' => '警告：「[_1]」物件並不屬於任何流程，所以已經被放入「[_2]」流程中。',
    'Welcome to Bricolage.' => '歡迎使用 Bricolage',
    'Welcome to Cyclops.' => '歡迎來到 Cyclops.',
    'Words' => '字',
    'Workflow Manager' => '流程管理',
    'Workflow Permissions' => '流程權限',
    'Workflow profile [_1] deleted.' => '流程設定 [_1] 已刪除。',
    'Workflow profile [_1] saved.' => '流程設定 [_1] 已儲存。',
    'Workflow' => '流程',
    'Workflows' => '流程',
    'Workspace for [_1]' => '[_1] 的工作區',
    'Writing files to "[_1]" Output Channel.' => '正將檔案寫至「[_1]」輸出頻道',
    'Year' => '年',
    'Yes' => '是',
    'You are about to permanently delete items! Do you wish to continue?' => '這些項目將被永久刪除！真的要繼續嗎？',
    'You cannot remove all Sites.' => '不能移除所有站台',
    'You have not been granted <b>[_1]</b> access to the <b>[_2]</b> [_3]' => '您並未允許 <b>[_1]</b> 存取 <b>[_2]</b> [_3]',
    'You must be an administrator to use this function.' => '此功能只有管理員才可行使',
    'You must select an Element or check the &quot;Generic&quot; check box.' => '你必須選擇一個元素，或是核選「通用」的核選方塊',
    'You must select an Element.' => '您必須選擇一個元素',
    'You must supply a unique name for this role!' => '你必須替這個角色取個獨一無二的名字',
    'You must supply a value for ' => '您必須給定其值',
    '[_1] Field Text' => '[_1] 欄位文字',
    '[_1] recipients changed.' => '[_1] 個收件者已更動。',
    '[quant,_1,Alert] acknowledged.' => '警告已被確認',
    '[quant,_1,Contributor] "[_2]" associated.' => '已關聯至此供稿者：「[_2]」',
    '[quant,_1,Template] deployed.' => '模板已經配備完成',
    '[quant,_1,media,media] published.'   => '[_1] 個媒體出版完成。',
    '[quant,_1,story,stories] published.' => '[_1] 篇稿件出版完成。' ,
    'all' => '全部',
    'one per line' => '一行一個',
    'to' => '到',
   '_AUTO' => 1,
);

=begin comment

To translate:
  '[_1] Site [_2] Permissions' => '[_1] [_2] Permissions', # Site Category Permissions
  'All Categories' => 'All Categories',
  'Object Groups' => 'Object Groups',
  '[_1] Site Categories' => '[_1] Site Categories',
  'You do not have permission to override user "[_1]"' => 'You do not have permission to override user "[_1]"'
  'Please select a primary output channel' => 'Please select a primary output channel',

=end comment

=cut

1;

__END__

=head1 AUTHOR

Kang-min Liu <gugod@gugod.org>

=head1 SEE ALSO

L<Bric::Util::Language|Bric::Util::Language>

=cut


1;
