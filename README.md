# ShellTool
Try to write some shell script to make develop easier

## ShowGitDiff
Be easy to show the difference point between two commit. You can filter with author name. It will create two folders to store the files which are changed by the author. Then it will open BeyondCompare(if you installed it) automatically.

方便地展示出某两次提交中所有的不同点。你可以输入author name去过滤出这个作者的提交文件。脚本将会创建两个文件夹存放两个版本中该作者更改过的文件，然后将会自动打开软件Beyond Compare，方便地进行文件更改比较。

### Format
sh ShowGitDiff.sh [Project Path] [Commit1 Hash] [Commit2 Hash] [AuthorName(Optional)]

### Command Demo:

```
sh ShowGitDiff.sh /Users/brucezhu/Code/GitDemo d7a9450ea15c99c7b2c673402d93cc9fcfb845d8 54978b51d2e79f4575c1bb87ebce7b6357ab2b12
or add author name filter:
sh ShowGitDiff.sh /Users/brucezhu/Code/GitDemo d7a9450ea15c99c7b2c673402d93cc9fcfb845d8 54978b51d2e79f4575c1bb87ebce7b6357ab2b12 Bruce
```


## AutoFormat(For Android Studio)
Auto format the codes from java files which are changed by yourself between two commit.

将两次提交之间自己做了更改的java文件进行Android Studio自带的代码格式化。

Background: As the codes of the old project are redundancy, the team is not allowed to format all the code for once, it is avoid to the problem which is hard to search the history changes log, and any other unknown problem. The team request that, every time before release, format the codes from java files which are changed by yourself, so I write this script file to reduce the workload.

背景：由于老代码冗余，项目不允许一次性将所有代码进行格式化，以避免查询历史更改记录困难及其他未知问题。项目要求每次迭代版本中，将自己更改了代码的java文件进行格式化，因此编写此脚本以减少工作量。


### Format
sh AutoFormat.sh [Project Path] [Commit1 Hash] [Commit2 Hash] [AuthorName(Optional)]


### Command Demo:

```
sh AutoFormat.sh /Users/brucezhu/Code/GitDemo d7a9450ea15c99c7b2c673402d93cc9fcfb845d8 54978b51d2e79f4575c1bb87ebce7b6357ab2b12
or add author name filter:
sh AutoFormat.sh /Users/brucezhu/Code/GitDemo d7a9450ea15c99c7b2c673402d93cc9fcfb845d8 54978b51d2e79f4575c1bb87ebce7b6357ab2b12 Bruce
```


