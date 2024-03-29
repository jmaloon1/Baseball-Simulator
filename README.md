# Baseball-Simulator
     
This Repository looks at trying to predict theoutcomes of Major League Baseball (MLB) games. It takes stats from *fangraphs.com* and projects outcomes based on each player's past performance. 

## Versions

- 1.1 - First iteration. Uses weighted average of player split stats (L/R Home/Away)since 2015 with emphasis on more recent years
- 1.2 - Fixed some bugs with roster creation and included more accurate in-game pitching changes
- 1.3 - Introduced Stolen Bases to simulations and added park factors
- 1.4 - Updated how player projections are calculated
- 1.5 Added more home field advantage based on past home and away performance and started regressing stats with fangrpahs projections

## Next Steps

* Use fangraphs API instead of web scraping to get more stats more easily
* Use more advanced stats and apply machine learning algorithms with train/test splits to better project future performance
* Test against betting lines and other projection websites to see if this projection system performs adequately
