# ShellTool
Try to write some shell script to make develop easier

## ShowGitDiff
Be easy to show the difference point between two commit. You can filter with author name. It will create two folders to store the files which are changed by the author. Then it will open BeyondCompare(if you installed it) automatically.
方便地展示出某两次提交中所有的不同点。你可以输入author name去过滤出这个作者的提交文件。脚本将会创建两个文件夹存放两个版本中该作者更改过的文件，然后将会自动打开软件Beyond Compare，方便地进行文件更改比较。

### Command Demo:

```
sh ShowGitDiff.sh /Users/brucezhu/Code/GitDemo d7a9450ea15c99c7b2c673402d93cc9fcfb845d8 54978b51d2e79f4575c1bb87ebce7b6357ab2b12
or add author name filter:
sh ShowGitDiff.sh /Users/brucezhu/Code/GitDemo d7a9450ea15c99c7b2c673402d93cc9fcfb845d8 54978b51d2e79f4575c1bb87ebce7b6357ab2b12 Bruce
```
